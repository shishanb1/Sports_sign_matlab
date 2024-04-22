%% 清空变量
clear
clc
timeAve = zeros(20,1);
proSuccess = zeros(20,1);
pm0Iter = zeros(20,1);
pmkIter = zeros(20,1);
pmIter = zeros(20,1);
NumberbestValue = zeros(7,1);
%bestValueTarget (1:7,1) = [21 18 17 16 14 13  0 ];  % 可能的最优解集
bestValueTarget (1:7,1) = [15 14 12 11 9 6  0 ];  % 可能的最优解集
testMax = 100; %100总测试次数
pm_set = 0.3;
for iterMaxIndex = 1:20
    bestTestValue= zeros(testMax,1);    %每次测试的最优值数组
    timeValue = zeros(testMax,1); 
    NumberbestValue = zeros(7,1);
    pmValue =  zeros(testMax,1); 
    pm0_set = 0.15 + 0.02 *(iterMaxIndex-1);
    %pm0_set = 0.28;
    %pmk_set = 0.2 + 0.03*(iterMaxIndex-1);
    pmk_set = 0.5;
    pm0Iter(iterMaxIndex)=pm0_set;
    pmkIter(iterMaxIndex)=pmk_set;
    %pmIter(iterMaxIndex)=pmk;
    for testNum = 1:testMax
        %[bestValue,xmax,gaTime,pm_mean] = gaFunction(pm_set,500);
        [bestValue,xmax,gaTime,pm_mean] = gaFunction(pm0_set,pmk_set,500,0);
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
%plot(pmIter,proSuccess,'Color',[1 0 0],'LineStyle','-','LineWidth',1)
plot(pm0Iter,proSuccess,'r',pm0Iter,pmIter,'b')
grid on;
xlabel('固定变异算子')
ylabel('全局最优收敛率')
title('全局最优收敛率与变异算子关系图')
disp('=======================')
    


