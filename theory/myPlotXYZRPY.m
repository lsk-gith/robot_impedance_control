function myPlotXYZRPY(xehist,traj_des_XYZeul,F)
figure
subplot(4,2,1);
plot(F,'DisplayName','F','LineWidth',1.2)
ylabel('F');
xlabel('time');
title('F(ext)');
legend('Fx','Fy','Fz','Nx','Ny','Nz');
subplot(4,2,2);
plot(F,'DisplayName','F','LineWidth',1.2)
ylabel('F');
xlabel('time');
title('F(ext)');
legend('Fx','Fy','Fz','Nx','Ny','Nz');
subplot(4,2,3);
plot(xehist(:,1),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(traj_des_XYZeul(:,1),'DisplayName','thetalist','LineWidth',1.2);
ylabel('x');
xlabel('time');
title('x轴位置');
legend('实际x轴位置变化','理论x轴位置变化');
subplot(4,2,4);
plot(xehist(:,4),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(traj_des_XYZeul(:,4),'DisplayName','thetalist','LineWidth',1.2);
ylabel('R');
xlabel('time');
title('姿态R变化');
legend('实际R角度变化','理论R角度变化');
subplot(4,2,5);
plot(xehist(:,2),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(traj_des_XYZeul(:,2),'DisplayName','thetalist','LineWidth',1.2);
ylabel('y');
xlabel('time');
title('y轴位置');
legend('实际y轴位置变化','理论y轴位置变化');
subplot(4,2,6);
plot(xehist(:,5),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(traj_des_XYZeul(:,5),'DisplayName','thetalist','LineWidth',1.2);
ylabel('P');
xlabel('time');
title('姿态P变化');
legend('实际P角度变化','理论P角度变化');
subplot(4,2,7);
plot(xehist(:,3),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(traj_des_XYZeul(:,3),'DisplayName','thetalist','LineWidth',1.2);
ylabel('z');
xlabel('time');
title('z轴位置');
legend('实际z轴位置变化','理论z轴位置变化');
subplot(4,2,8);
plot(xehist(:,6),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(traj_des_XYZeul(:,6),'DisplayName','thetalist','LineWidth',1.2);
ylabel('Y');
xlabel('time');
title('姿态Y变化');
legend('实际Y角度变化','理论Y角度变化');
end