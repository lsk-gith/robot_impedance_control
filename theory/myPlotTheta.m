function myPlotTheta(q_record,thetalist,F)
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
plot(q_record(:,1),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(thetalist(:,1),'DisplayName','thetalist','LineWidth',1.2);
ylabel('theta1');
xlabel('time');
title('theta');
legend('实际关节角度','理论关节角度');
subplot(4,2,4);
plot(q_record(:,2),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(thetalist(:,2),'DisplayName','thetalist','LineWidth',1.2);
ylabel('theta2');
xlabel('time');
title('theta');
legend('实际关节角度','理论关节角度');
subplot(4,2,5);
plot(q_record(:,3),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(thetalist(:,3),'DisplayName','thetalist','LineWidth',1.2);
ylabel('theta3');
xlabel('time');
title('theta');
legend('实际关节角度','理论关节角度');
subplot(4,2,6);
plot(q_record(:,4),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(thetalist(:,4),'DisplayName','thetalist','LineWidth',1.2);
ylabel('theta4');
xlabel('time');
title('theta');
legend('实际关节角度','理论关节角度');
subplot(4,2,7);
plot(q_record(:,5),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(thetalist(:,5),'DisplayName','thetalist','LineWidth',1.2);
ylabel('theta5');
xlabel('time');
title('theta');
legend('实际关节角度','理论关节角度');
subplot(4,2,8);
plot(q_record(:,6),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(thetalist(:,6),'DisplayName','thetalist','LineWidth',1.2);
ylabel('theta6');
xlabel('time');
title('theta');
legend('实际关节角度','理论关节角度');
end