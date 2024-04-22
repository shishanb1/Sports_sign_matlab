
%% 清空变量
clear
clc
timeAve = zeros(20,1);
proSuccess = zeros(20,1);
nmIter = zeros(20,1);
NumberbestValue = zeros(7,1);
%bestValueTarget (1:7,1) = [21 18 17 16 14 13  0 ];  % 可能的最优解集
bestValueTarget (1:7,1) = [15 14 12 11 10 9  0 ];  % 可能的最优解集
testMax = 100; %1000总测试次数
nm_set = 100;
for iterMaxIndex = 1:20
    bestTestValue= zeros(testMax,1);    %每次测试的最优值数组
    timeValue = zeros(testMax,1); 
    NumberbestValue = zeros(7,1);
    pmValue =  zeros(testMax,1); 
    %pm0_set = 0.1 + 0.02 *(iterMaxIndex-1);
    %pm0_set = 0.28;
    %pmk_set = 0.2 + 0.03*(iterMaxIndex-1);
    pmk_set = 0.5;
    pm0_set = 0.30;
    iter_set = nm_set + 50*(iterMaxIndex-1);
    %pm0Iter(iterMaxIndex)=iter_set;
    %pmkIter(iterMaxIndex)=iter_set;
    nmIter(iterMaxIndex)=iter_set;
    %pmIter(iterMaxIndex)=pmk;
    for testNum = 1:testMax
        %[bestValue,xmax,gaTime,pm_mean] = gaFunction(pm_set,500);
        %[bestValue,xmax,gaTime,pm_mean] = gaFunction(pm0_set,pmk_set,500);
        [bestValue,xmax,gaTime,pm_mean] = gaFunction(pm0_set,pmk_set,iter_set,0);
        timeValue(testNum)=gaTime;
        pmValue(testNum)=pm_mean;
        for i=1:7
        if(bestValue== bestValueTarget(i))
            NumberbestValue(i)=NumberbestValue(i)+1 ;
        end
        end
    end
    for i=1:7
            disp(['NumberbestValue：',num2str(NumberbestValue(i))]);
    end
    proSuccess(iterMaxIndex)=NumberbestValue(1)/sum(NumberbestValue);
    iterTime(iterMaxIndex)=mean(timeValue);
    pmIter(iterMaxIndex)=mean(pmValue);
    disp(['proSuccessRate：',num2str(proSuccess(iterMaxIndex))]);
    disp(['pmIter：',num2str(pmIter(iterMaxIndex))]);
end

figure(1)
%plot(iterPm,proSuccess,'Color',[1 0 0],'LineStyle','-','LineWidth',1)
%plot(nmIter,proSuccess,'Color',[1 0 0],'LineStyle','-','LineWidth',1)
%plot(pmkIter,proSuccess,'r',pmkIter,pmIter,'b')
%plot(pmIter,proSuccess,'Color',[1 0 0],'LineStyle','-','LineWidth',1)
plot(nmIter,proSuccess,'r',nmIter,pmIter,'b')
grid on;
xlabel('最大进化代数')
ylabel('全局最优收敛率')
title('全局最优收敛率与最大进化代数关系图')
disp('=======================')
    