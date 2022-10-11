clear;clc;
load('dataFromReal.txt');
q=dataFromReal(:,1:6)./10./180*pi;
X=[];
Y=[];
Z=[];
for i = 1:size(q,1)
    T = transion(q(i,1),q(i,2),q(i,3),q(i,4),q(i,5),q(i,6));
    X=[X,T(1)];
    Y=[Y,T(2)];
    Z=[Z,T(3)];
end
plot3(X,Y,Z,'b');