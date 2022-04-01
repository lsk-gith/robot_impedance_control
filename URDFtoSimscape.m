clear,clc;
rocr6II=importrobot('ROCR6II_URDF_file.urdf');%导入URDF文件
rocr6II.DataFormat='column';robot.DataFormat='column';%数据格式为列，row为行；为‘row'时q0要转置为q0’
show(rocr6II,[pi/2.5 pi/6 1.5 1.2 pi/5 pi/7]','PreservePlot',false);
axis([-0.6,0.6,-0.6,0.6,0,1]);
showdetails(rocr6II) %显示连杆间的父子关系
initialguess= homeConfiguration(rocr6II);
show(rocr6II,initialguess,'Frames','off','Visuals' ,'on');%figure显示
axis([-0.6,0.6,-0.6,0.6,0,1]);
% rocr6IISM = smimport('ROCR6II_URDF_file.urdf');%生成Simscape物理模型