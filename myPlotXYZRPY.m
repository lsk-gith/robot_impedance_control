function myPlotXYZRPY(RPY_real,RPY_theory,F)
figure
subplot(3,2,1);
plot(RPY_real(:,1),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(RPY_theory(:,1),'DisplayName','thetalist','LineWidth',1.2);
ylabel('x');
xlabel('time');
title('x轴位置');
legend('实际x轴位置变化','理论x轴位置变化');
subplot(3,2,2);
plot(RPY_real(:,4),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(RPY_theory(:,4),'DisplayName','thetalist','LineWidth',1.2);
ylabel('R');
xlabel('time');
title('姿态R变化');
legend('实际R角度变化','理论R角度变化');
subplot(3,2,3);
plot(RPY_real(:,2),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(RPY_theory(:,2),'DisplayName','thetalist','LineWidth',1.2);
ylabel('y');
xlabel('time');
title('y轴位置');
legend('实际y轴位置变化','理论y轴位置变化');
subplot(3,2,4);
plot(RPY_real(:,5),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(RPY_theory(:,5),'DisplayName','thetalist','LineWidth',1.2);
ylabel('P');
xlabel('time');
title('姿态P变化');
legend('实际P角度变化','理论P角度变化');
subplot(3,2,5);
plot(RPY_real(:,3),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(RPY_theory(:,3),'DisplayName','thetalist','LineWidth',1.2);
ylabel('z');
xlabel('time');
title('z轴位置');
legend('实际z轴位置变化','理论z轴位置变化');
subplot(3,2,6);
plot(RPY_real(:,6),'DisplayName','q_record','LineWidth',1.2);
hold on
plot(RPY_theory(:,6),'DisplayName','thetalist','LineWidth',1.2);
ylabel('Y');
xlabel('time');
title('姿态Y变化');
legend('实际Y角度变化','理论Y角度变化');
end