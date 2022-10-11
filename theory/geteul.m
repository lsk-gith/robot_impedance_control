function [endPoint] = geteul(theta)
% this function is get the endPoint xyz and phi xi theta.
% input: theta joint angle (NX6)
% output: endPoint (NX6)
for i = 1:size(theta,1)
    T = transion(theta(i,1),theta(i,2),theta(i,3),theta(i,4),theta(i,5),theta(i,6));
    endPoint(i,:) = [T(1,4),T(2,4),T(3,4),tr2rpy(T)];
end
end
