% This function was obtained from Peter Corke's MATLAB toolbox
function euler = tr2eul(R, varargin)
    opt.deg = false;
    opt.flip = false;
%     opt = tb_optparse(opt, varargin);
    s = size(R);
    if length(s) > 2
        euler = zeros(s(3), 3);
        for i=1:s(3)
            disp('0');
            euler(i,:) = tr2eul(R(:,:,i));
        end
        if opt.deg
            euler = euler * 180/pi;
        end
        return
    end
	euler = zeros(1,3);
	% Method as per Paul, p 69.
    % euler = [phi theta psi]
    %
	if abs(R(1,3)) < eps && abs(R(2,3)) < eps
        disp('1');
		% singularity
		euler(1) = 0;
		sp = 0;
		cp = 1;
		euler(2) = atan2(cp*R(1,3) + sp*R(2,3), R(3,3));
		euler(3) = atan2(-sp * R(1,1) + cp * R(2,1), -sp*R(1,2) + cp*R(2,2));
    else
        % non singular
%         disp('2');
        % Only positive phi is returned.
        if opt.flip
            euler(1) = atan2(-R(2,3), -R(1,3));
        else
            euler(1) = atan2(R(2,3), R(1,3));
        end
		sp = sin(euler(1));
		cp = cos(euler(1));
		euler(2) = atan2(cp*R(1,3) + sp*R(2,3), R(3,3));
		euler(3) = atan2(-sp * R(1,1) + cp * R(2,1), -sp*R(1,2) + cp*R(2,2));
	end
    if opt.deg
        euler = euler * 180/pi;
    end
end