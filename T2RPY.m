function  X=T2RPY(T)
%#codegen
coder.extrinsic('disp'); %Declare disp as extrinsic
    %% 求末端位置
    x=T(1,4);y=T(2,4);z=T(3,4);
    %% 根据X-Y-Z固定角计算
    R=T;rpy=[0,0,0];
    if abs(abs(R(3,1)) - 1) < 0.000001  % when |R31| == 1
    % singularity
        rpy(1) = 0;     % roll is zero
        if R(3,1) < 0
            rpy(3) = -atan2(R(1,2), R(1,3));  % R-Y
        else
            rpy(3) = atan2(-R(1,2), -R(1,3));  % R+Y
        end
        rpy(2) = -asin(R(3,1));
    else
        rpy(1) = atan2(R(3,2), R(3,3));  % R
        rpy(3) = atan2(R(2,1), R(1,1));  % Y

        [~,k] = max(abs( [R(1,1) R(2,1) R(3,2) R(3,3)] ));
        switch k
            case 1
                rpy(2) = -atan(R(3,1)*cos(rpy(3))/R(1,1));
            case 2
                rpy(2) = -atan(R(3,1)*sin(rpy(3))/R(2,1));
            case 3
                rpy(2) = -atan(R(3,1)*sin(rpy(1))/R(3,2));
            case 4
                rpy(2) = -atan(R(3,1)*cos(rpy(1))/R(3,3));
        end
    end
%     RPY=rpy*180/pi;
    RPY=rpy;
    Roll=RPY(1);Pitch=RPY(2);Yaw=RPY(3);
    X=[x,y,z,Roll,Pitch,Yaw];
end