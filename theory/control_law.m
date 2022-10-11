function [hehist,xehist,q_record,dq_record,ddq_record] = control_law(F_ext,traj_XYZeul,thetalist,dthetalist,ddthetalist)
% input: F_ext external Force and torque (6X1)
% input: traj_XYZeul XYZeul (NX6)
load('vars_for_cb');
% save('vars_for_cb','iter','dt','M','C','G','R0tip','Janasym','Janadot','Jgeom','Md','Kp','Kd','P_fin','q_vec','qdot_vec','xe','xddoubled','xtildedot','j','qnew','qdotnew','g','omega','euldot_old','qUlim','qLlim','Pdot','xddot');
q_record = [];
dq_record = [];
ddq_record = [];
hehist = [];
j=0;
he_app = F_ext;
% Start iterating
for i = 1:iter
tic;
    j=j+1;
    disp(['Iteration: ',num2str(j)]);
    if(j>=50 && j<=100)
        he = he_app;
    else
        he = [0 0 0 0 0 0]';
    end
    hehist(j,:) = he';
    M_num = double(subs(M,q_vec,qnew));
%     Cqdot and G are not used in the control law as they get cancelled out. However, they are defined here for consistency but are commented out.
%     Cqdot_num = subs(Cqdot,[q_vec,qdot_vec],[qnew,qdotnew]);
%     G_num = subs(G,[g,q_vec.'],[9.81,qnew.']);
    %Calculate numeric rotation matrix
    R0tip_num = double(subs(R0tip,q_vec,qnew));
    actureeul = tr2rpy(R0tip_num); 
	acturephi = actureeul(1);acturetheta = actureeul(2);acturexi = actureeul(3);
    % This if condition is to keep the jacobians constant for every 20
    % iterations. We could do this, but we will get plots with a step-like
    % response indicating some level of discontinuity. The iterations also
    % run faster with the if condition. Time per iteration without the if
    % condition (calculating jacobians every iteration) is 0.6 seconds while
    % time per iteration with the if condition (calculating jacobians once
    % every 20 iterations) is 0.35 seconds.
    % To get faster plots, the if condition is used by default.
    % Please comment out the if along with its corresponding end 
    % to get smooth plots.
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     if(j==1)
%     if(mod(j,20) == 0 || j==1)
        % Calculate Analytical Jacobian and its 1st derivative numerical updates
        eul = tr2rpy(R0tip_num);
        phi = eul(1);theta = eul(2);xi = eul(3);
%       om2eulmat = [0 -sin(phi) cos(phi)*sin(theta);0  cos(phi) sin(phi)*sin(theta);1     0    cos(theta)];
        om2eulmat = [cos(theta)*cos(xi), -sin(xi), 0;cos(theta)*sin(xi),  cos(xi), 0;-sin(theta),       0, 1];
        euldot = double(om2eulmat\omega);
        Janasym(4:6,:) = euldot;
        Jana_num = double(subs(Janasym,q_vec,qnew));
%         Jana_num
        Janadot_num = double(subs(Janadot,[q_vec,qdot_vec],[qnew,qdotnew]));
        Janadot_num(4:6,:) = (euldot-euldot_old);
%         Janadot_num
        % Calcualte Geometric Jacobian numeric update
%         Jgeom_num = double(subs(Jgeom,q_vec,qnew));
        Jgeom_num = Jge(qnew(1),qnew(2),qnew(3),qnew(4),qnew(5));
        omega = Jgeom_num(4:6,:);
%     end   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%   thery trajectory
%     xd = traj_XYZeul(j,:)'; 
    [Xdd, Xd, X, Jananew_e] = getDesiredX(thetalist(j,:)',dthetalist(j,:)',ddthetalist(j,:)',Janaold_e);
    Janaold_e = Jananew_e;
 %%    
    % Calculate xtilde
    xtilde = X - xe;
%     xtilde
    % Control law for the inverse dynamics impedance control Resolved acceleration a_q calculation. xddoubled is theory,can use ddx = dJ_ana * dq + J_ana * ddq;
    aq = double(Jana_num\(Xdd + Md\Kd*xtildedot + Md\Kp*xtilde - Janadot_num*qdotnew));
% Janadot_num

    % Calculate q_double_dot (Joint accelerations)
%     M_num\eye(6)
%     qdotdot = double(aq - M_num\Jgeom_num'*he);
    qdotdot = double(aq - Jgeom_num'*he);
%     Jgeom_num
    ddq_record = [ddq_record;qdotdot'];
    % Calculate joint velocities by numerically forward integrating  with time.
    qdotnew = qdotnew + qdotdot.*dt;
    dq_record = [dq_record;qdotnew'];
    % Calculate joint angle values by numerically forward integrating with time.
    qnew = qnew + qdotnew.*dt;
    q_record = [q_record;qnew'];
 %%   Check for joint limits and break if joint limits exceeded
%     if(sum(qnew>qUlim)>0 || sum(qnew<qLlim)>0)
%         qlimflag = 1;
%         break;
%     end
 %%   Calculate individual joint cartesian positions 
    EEpos = double(subs(P_fin,q_vec,qnew));
    % Save individual joint cartesian positions over iterations for animating the plot
    EEpos_fin(:,j) = EEpos';
%% Calculate current pose (position and orientation) of the end effector
    xe = [EEpos;acturephi;acturetheta;acturexi];
    % Save over iterations
    xehist(j,:) = xe';
    % Calculate end effector velocity
    xedot = [double(subs(Pdot,[q_vec,qdot_vec],[qnew,qdotnew]));euldot*qdotnew];
    % Calculate xtilde
    xtilde = X-xe;
    % Calculate xtilde_dot, xddot is theory can use dx = J_ana * dq 
    xtildedot = Xd - xedot;
    % Set euldot_old as euldot
    euldot_old = euldot;
    toc
end
end