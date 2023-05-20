clc;
clear all;
close all;

slots=16;
y1=camera1();
y2=camera2();
if y1==0 & y2==0
    disp('No slots left \n');
    fprintf('Total cars in the parking space %d \n',y1+y2);
else
    disp('Available slots shown above');
    fprintf('Total available slots %d \n',slots-y1-y2);
end
