%% ��ձ���
clear
clc
timeAve = zeros(20,1);
proSuccess = zeros(20,1);
nmIter = zeros(20,1);
NumberbestValue = zeros(7,1);
bestValueTarget (1:7,1) = [15 14 12 11 10 9  0 ];  % ���ܵ����Ž⼯
testMax = 100; %1000�ܲ��Դ���
nm_set = 100;
pmk_set = 0.5;
pm0_set = 0.30;
iter_set = 1000;
ifPrint = 1;
[bestValue,xmax,gaTime,pm_mean] = gaFunction(pm0_set,pmk_set,iter_set,1);
