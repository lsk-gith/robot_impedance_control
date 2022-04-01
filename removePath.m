rootDir = fileparts(which(mfilename));
rmpath(genpath('ROCR6II_URDF_file'),'CAD_Model');
rmpath('work');
Simulink.fileGenControl('reset');