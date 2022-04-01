function myPlotTheta(q_theory,q_real,F)
figure
subplot(3,2,1);
plot(q_theory(:,1),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(q_real(:,1),'DisplayName','thetalist','LineWidth',1.2);
ylabel('theta1');
xlabel('time');
title('theta');
legend('实际关节角度','理论关节角度');
subplot(3,2,2);
plot(q_theory(:,2),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(q_real(:,2),'DisplayName','thetalist','LineWidth',1.2);
ylabel('theta2');
xlabel('time');
title('theta');
legend('实际关节角度','理论关节角度');
subplot(3,2,3);
plot(q_theory(:,3),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(q_real(:,3),'DisplayName','thetalist','LineWidth',1.2);
ylabel('theta3');
xlabel('time');
title('theta');
legend('实际关节角度','理论关节角度');
subplot(3,2,4);
plot(q_theory(:,4),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(q_real(:,4),'DisplayName','thetalist','LineWidth',1.2);
ylabel('theta4');
xlabel('time');
title('theta');
legend('实际关节角度','理论关节角度');
subplot(3,2,5);
plot(q_theory(:,5),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(q_real(:,5),'DisplayName','thetalist','LineWidth',1.2);
ylabel('theta5');
xlabel('time');
title('theta');
legend('实际关节角度','理论关节角度');
subplot(3,2,6);
plot(q_theory(:,6),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(q_real(:,6),'DisplayName','thetalist','LineWidth',1.2);
ylabel('theta6');
xlabel('time');
title('theta');
legend('实际关节角度','理论关节角度');
end