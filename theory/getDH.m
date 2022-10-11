clear,clc,close;
%% orign data
% [THETA D A ALPHA SIGMA OFFSET]
% L1 = Link([0    121.5    0         0        0    0],'modified'); 
% L2 = Link([0    0        0         pi/2     0    -pi/2],'modified');
% L3 = Link([0    0        -300      0        0    0],'modified');
% L4 = Link([0    110.5    -276      0        0     -pi/2],'modified');
% L5 = Link([0    90       0         pi/2     0    0],'modified');
% L6 = Link([0    82       0         -pi/2     0    0],'modified');
%% my modify data
%a=[0 0 0.264 0.237 0 0];
% d=[0.144 0 -0.0075 0.114 0.114 0.067];
% thet=[0 pi/2 0 -pi/2 0 0];
L1 = Link([0    144      0         0        0    0],'modified'); 
L2 = Link([0    0        0         pi/2     0    pi/2],'modified');
L3 = Link([0    -7.5     264       0        0    0],'modified');
L4 = Link([0    144      237       0        0     -pi/2],'modified');
L5 = Link([0    144      0         -pi/2     0    0],'modified');
L6 = Link([0    67       0         pi/2     0    0],'modified');
%% 
robot = SerialLink([L1 L2 L3 L4 L5 L6],'name','Arm6')
ze = [0 0 0 0 0 0];
% ze=[30 30 30 30 30 30];
% ze=[-30 -30 -30 -30 -30 -30];
% ze=[0,90,0,0,90,0];
% ze=[0,-90,0,0,-90,0];
% ze= [65.3697  -39.5894  -79.4194   29.0088  -90.0000 -155.3697];  % 0 0 0 300 400 300
% ze=[ 65.3697  -39.5894  -79.4194   29.0088  -90.0000  -65.3697]; %90 0 0  300 400 300
%  ze=[73.0165  -60.9837  -50.4019  111.3855   16.9835    0.0000];%90 90 180 300 400 300
% ze=[76.1029  -40.6594  -39.1558   79.8152  -76.1029  150.0000];%-30 0 90 200 300 500
% ze=[83.6375    2.5241  -86.3509   13.2269  -27.3276 -137.9331]; %30 60 30 200 300 500
ze=ze/180*pi;
forwarda=robot.fkine(ze)
view(3)
robot.plot(ze)
q1=robot.ikine(forwarda)
rpy=tr2rpy(forwarda, 'xyz')*180/pi
robot.teach(forwarda,'rpy' )