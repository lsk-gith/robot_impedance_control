close all;clc;
%% load data
syms q_vec q1 q2 q3 q4 q5 q6 g real;
syms t t1(t) t2(t) t3(t) t4(t) t5(t) t6(t);
syms q1dot q2dot q3dot q4dot q5dot q6dot real;
syms t1dot(t) t2dot(t) t3dot(t) t4dot(t) t5dot(t) t6dot(t);
syms q1dotdot q2dotdot q3dotdot q4dotdot q5dotdot q6dotdot real;
syms t1dotdot(t) t2dotdot(t) t3dotdot(t) t4dotdot(t) t5dotdot(t) t6dotdot(t);
q_vec = [q1 q2 q3 q4 q5 q6].';
t_vec = [t1 t2 t3 t4 t5 t6].';
tdot_vec = [diff(t1(t),t) diff(t2(t),t) diff(t3(t),t) diff(t4(t),t) diff(t5(t),t) diff(t6(t),t)].';
tdotdot_vec = [diff(t1dot(t),t) diff(t2dot(t),t) diff(t3dot(t),t) diff(t4dot(t),t) diff(t5dot(t),t) diff(t6dot(t),t)].';
tdotsh_vec = [t1dot(t) t2dot(t) t3dot(t) t4dot(t) t5dot(t) t6dot(t)].';
tdotdotsh_vec = [t1dotdot(t) t2dotdot(t) t3dotdot(t) t4dotdot(t) t5dotdot(t) t6dotdot(t)].';
qdot_vec = [q1dot q2dot q3dot q4dot q5dot q6dot].';
qdotdot_vec = [q1dotdot q2dotdot q3dotdot q4dotdot q5dotdot q6dotdot].';
load(('.\InverseDynamic\MCG.mat'));

%% Forward Kinematics
P_fin = P; %Extracting only the x-y-z position from T matrix 
P_fint = subs(P_fin,q_vec,t_vec); % substitute time dependence 
Pdottemp = diff(P_fint,t); % Pdot differentiate w.r.t. time
Pdot = subs(Pdottemp,[t_vec,tdot_vec],[q_vec,qdot_vec]); % substitute time independence
R0tip = R;% rotation matrix of end point
% Initialize the robot at some position as home [0.5 0.5 0.2 0.2 0.2 0.2]';
% qHome = [pi/2.5 pi/6 1.5 1.2 pi/5 pi/7]';

load('.\Green2dai\data.mat');
thetalist = data(1:end,1:6);%这里所有的量都应该是N*6的形式
dthetalist = data(1:end,7:12);
ddthetalist = data(1:end,13:18);
qHome = thetalist(1,:)';
% Calculate numerical transformation matrix
T_fin=[[R;0,0,0],[P;1]];
matlabFunction(T_fin,'File','transion');
THome = subs(T_fin,q_vec,qHome);
%% Geometric and Analytical Jacobian Calculation Calculate the first three rows of Jacobian (common to Analytical and Geometric Jacobians) J3 = jacobian(P_fin,q_vec)'Janasym','Janadot','Jgeom'
J3=J(1:3,1:6);
% omega = last three rows of geometric Jacobian as defined by axis of rotation with respect to the base frame.
omega1 = double(subs(J,q_vec,qHome));
omega=omega1(4:6,1:6);
% Combine to form the Geometric Jacobian Jgeom = [J3;omega];
Jgeom = J;
Jge = J;
matlabFunction(Jge,'File','Jge');
% Calculate rpy Angles from Transformation Matrix using Peter Corke's tr2eul function
eul = tr2rpy(THome);% 
% roll-pitch-yaw, i am lazy, so i dont want to change the name!!!!
phi = eul(1);theta = eul(2);xi = eul(3);
% EUL2JAC Euler angle rate Jacobian, this can reference the eul2jac.m function.
om2eulmat = [cos(theta)*cos(xi), -sin(xi), 0;cos(theta)*sin(xi),  cos(xi), 0;-sin(theta),       0, 1];
euldot = om2eulmat\omega;
% Symbolic Analytical Jacobian
Janasym = [J3;euldot];
% Symbolic First derivative of Analytical Jacobian
Janadot = subs(diff(subs(Janasym,q_vec,t_vec),t),[t_vec,tdot_vec],[q_vec,qdot_vec]);
Jdot = subs(diff(subs(J,q_vec,t_vec),t),[t_vec,tdot_vec],[q_vec,qdot_vec]);
JanadotUp3 = Jdot(1:3,:);
matlabFunction(JanadotUp3,'File','JanadotUp3');
%% Initialize variables for iterations
j=0;
% iter = 0:dt:time;
dt = 0.002;
iter = size(thetalist,1);
qnew=qHome;
q=qnew;
% qdotnew = [0 0 0 0 0 0]';
qdotnew = dthetalist(1,:)';
euldot_old = euldot;
% traj_des_theta = [qHome(1).*ones(size(iter,2),1),qHome(2).*ones(size(iter,2),1),qHome(3).*ones(size(iter,2),1),qHome(4).*ones(size(iter,2),1),qHome(5).*ones(size(iter,2),1),qHome(6).*ones(size(iter,2),1)];
traj_des_theta = thetalist;
traj_des_XYZeul = geteul(traj_des_theta);
%test 
Janaold = double(subs(Janasym,q_vec,thetalist(1,:)'));
[Xdd, Xd, X] = getDesiredX(thetalist(2,:)',dthetalist(2,:)',ddthetalist(2,:)',Janaold);
Janaold_e = double(subs(Janasym, q_vec, thetalist(1,:)'));
%% Initialize parameters for iterations
% Desired Mass of end effector
Md = 1*eye(6); 
% Desired spring of end effector
Kp = 5*eye(6);
% Desired Damping coefficient of end effector
Kd = 3*eye(6);
% End effector initial force vector
he = [0 0 0 0 0 0]';
% Initial end effector actual cartesian position
xe = [THome(1:3,4);phi;theta;xi];
% Initial end effector desired cartesian acceleration. ddx = dJ_ana * dq + J_ana * ddq
xddoubled = [0 0 0 0 0 0]';
% Initial end effector desired cartesian velocity.dx = J_ana * dq 
xddot = [0 0 0 0 0 0]';
% Initial end effector actual cartesian velocity
xedot = [subs(Pdot,[q_vec,qdot_vec],[qnew,qdotnew]);0;0;0];
% Initial difference in end effector desired and actual cartesian velocities
xtildedot = xddot - xedot;    
%% Pre-allocating size of matrices for simulation iterations
save('vars_for_cb','iter','M','C','G','R0tip','Janasym','Janadot','Jgeom','Md','Kp','Kd','P_fin','q_vec','qdot_vec','xe','xddoubled','xtildedot','j','qnew','qdotnew','g','omega','euldot_old','Pdot','xddot','J','Janaold_e','dt');
% F_ext =1.* [5,-6,5,0,0,0].';
F_ext =2.* [2,-4,-3,0,0,0].';
% F_ext =1.* [0,0,0,0,0,0].';
[F,xehist,q_record,dq_record,ddq_record] = control_law(F_ext,traj_des_XYZeul,thetalist,dthetalist,ddthetalist);
figure(1)
subplot(2,1,1);
plot(F,'DisplayName','F','LineWidth',1.2)
ylabel('F');
xlabel('time');
title('F(ext)');
subplot(2,1,2);
plot(q_record,'DisplayName','q_record','LineWidth',1.2);
ylabel('theta');
xlabel('time');
title('theta');
figure(2)
subplot(2,1,1);
plot(F,'DisplayName','F','LineWidth',1.2)
ylabel('F');
xlabel('time');
title('F(ext)');
subplot(2,1,2);
plot(xehist,'DisplayName','xehist','LineWidth',1.2)
ylabel('X');
xlabel('time');
title('X');
figure(3)
subplot(2,1,1);
plot(q_record-thetalist,'DisplayName','xehist','LineWidth',1.2)
subplot(2,1,2);
plot(xehist-traj_des_XYZeul,'DisplayName','xehist','LineWidth',1.2)
% figure(4);
% plot3(traj_des_XYZeul(1:end,1),traj_des_XYZeul(1:end,2),traj_des_XYZeul(1:end,3),'b');
% for i = 1 : size(xehist,1)
%     hold on
%     plot3(xehist(i,1),xehist(i,2),xehist(i,3),'-o','Color','r','MarkerSize',10,'MarkerFaceColor','#D9FFFF');
%     pause(0.001);
% end
figure(5);
plot3(traj_des_XYZeul(1:end,1),traj_des_XYZeul(1:end,2),traj_des_XYZeul(1:end,3),'b');
hold on
plot3(xehist(1:end,1),xehist(1:end,2),xehist(1:end,3),'Color','r');





figure(4);
plot3(traj_des_XYZeul(1:end,1),traj_des_XYZeul(1:end,2),traj_des_XYZeul(1:end,3),'b');
n = size(xehist,1) / 10;
for i = 1 : n
    hold on
    plot3(xehist(10 * i,1),xehist(10 * i,2),xehist(10 * i,3),'-o','Color','r','MarkerSize',10,'MarkerFaceColor','#D9FFFF');
    pause(0.001);
end