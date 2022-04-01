%使用simscape仿真时，X_sim没有值应该先注释掉
% 使用这个之前需要将仿真输出的数据导出来，并处理
%这个函数是为了显示运行轨迹的
q_real_my = out.q_real;
X_real = [];
RPY_real = [];
for i = 1:size(q_real_my,1)
    T = transion(q_real_my(i,1),q_real_my(i,2)-pi/2,q_real_my(i,3),q_real_my(i,4)-pi/2,q_real_my(i,5),q_real_my(i,6));
    RPY = T2RPY(T);
    RPY_real = [RPY_real;RPY];
    X_real = [X_real;T(1:3,4)'];
end
RPY_real = RPY_real(1:end - 1,:);
load('q.mat');
q_real_my = q';
X_theory = [];
RPY_theory = [];
for i = 1:size(q_real_my,1)
    T = transion(q_real_my(i,2),q_real_my(i,3),q_real_my(i,4),q_real_my(i,5),q_real_my(i,6),q_real_my(i,7));
    RPY = T2RPY(T);
    RPY_theory  = [RPY_theory;RPY];
    X_theory = [X_theory;T(1:3,4)'];
end

load('F.mat');
q = q(2:7,:)';
q(:,2) = q(:,2)+pi/2;
q(:,4) = q(:,4)+pi/2;
F = F(2:7,:)';
out.q_real = out.q_real(1:end - 1,:);
myPlotXYZRPY(RPY_real,RPY_theory,F)
myPlotTheta(q,out.q_real,F)