function [Xdd, Xd, X, Jana] = getDesiredX(q,dq,ddq,Janaold)
% q 6 X 1;
% dq 6 X 1;
% ddq 6 X 1;
% Xdd 6 X 1;
% xd 6 X 1;
T = transion(q(1),q(2),q(3),q(4),q(5),q(6));
Jg = Jge(q(1),q(2),q(3),q(4),q(5));
eul = tr2rpy(T);
phi = eul(1);theta = eul(2);xi = eul(3);
X = [T(1:3,4);phi;theta;xi];
om2eulmat = [cos(theta)*cos(xi), -sin(xi), 0;cos(theta)*sin(xi),  cos(xi), 0;-sin(theta),       0, 1];
omega = Jg(4:end,:);
JanaDown3 = om2eulmat\omega;
Jana = [Jg(1:3,:);JanaDown3];
JadotUp3 = JanadotUp3(q(1),q(2),q(3),q(4),q(5),dq(1),dq(2),dq(3),dq(4),dq(5));
Jadown3 = Jana - Janaold;
Janadot = [JadotUp3;Jadown3(4:6,:)];
Xd = Jana * dq;
Xdd = Janadot * dq + Jana * ddq;
end