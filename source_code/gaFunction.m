%问题二遗传算法求解
function [gradeMax,xMax,gaTime,pmR] = gaFunction(pm0,kpm,iterMax,ifPrint)
%function [gradeMax,xMax,gaTime,pmR] = gaFunction(pm0,kpm,iterMax)
%% 清空变量
%clear
%clc
tic
gradeMax = 0;
gaTime = 0;

%% 遗传算法解决运动会报名问题  % 
rng('shuffle')  % 控制随机数的生成，否则每次打开matlab得到的结果都一样
coord=readmatrix('grade.xlsx');
m = size(coord,2);  % 总的比赛项目数目
n = size(coord,1);  % 参赛队员的数目
class_num = 13; % 总的班级数目

max_class = 1; % 需要优化的的班级

max_grade = 0;
reward  = zeros(n,1); 
reward(1:8,1) = [9 7 6 5 4 3 2 1 ];  % 名次计分
w=[6 3 2 1];

%function[xmax,pmax,pmax_t ]=gaknaps(c1,p1,m1)
%[xmax,pmax]=gaknaps(cl,pl,m1)
%cl pl are raw vectors
%ml is the 1imit
%tic;
%设置基因位数
%num=size(c1,2);
num=m*n/class_num; %设置基因位数=20*4


populationNumber = 50; %种群规模大小 populationNumber
PopulationMat = zeros(populationNumber,1);

PopulationValue=rand(populationNumber,num)>0.5;
%当前迭代次数
%当前最优解的价值
pmax=0;
pmax_t=0;
%交叉算子
cross_p=0.8;
%变异概率
%pm = 0.6;
%pm = pm_set;
%总迭代次数
%iterMax = 1000; %1000总迭代次数
%iterMax = iter_set; %总迭代次数
bestValue = -inf;  %初始化找到的最佳的解对应的得分
bestValueMat = zeros(iterMax,1);    %每次迭代的最优值数组
bestIndividuialityMat = zeros(iterMax,80);

iter = 0;
max_grade = 0;     % 初始化找到的最佳的解对应的得分为grade0
result0 =readmatrix('x0.xlsx') %初始解，来自线性0-1规划的结果
%tempy = result0(1:20,1:4)';
tempy = result0(1:20,1:4);
PopulationValue(1, : )=reshape(tempy,1,80)';%初始解，赋值给第一个样本
%初始化种群
currPopuNum = 1;
%% 初始化个体
while currPopuNum<populationNumber
    %xtemp = gen_new_result(tempy',1);
    xtemp = gen_new_result(tempy,1);
    if(isTrueIndividual(xtemp,4))
        currPopuNum=currPopuNum+1;
        PopulationValue(currPopuNum, : )=reshape(xtemp,1,80);
    end
end
PopulationMat = PopulationValue;
while iter<iterMax
    iter=iter+1;
    %compute fitness
    %若基因所有位都为0，则重新设置
    for i=1:populationNumber
        if PopulationMat(i, : )==0
            PopulationMat(i, : )=-1-PopulationMat(i, : );
            disp('erro');
        end
    end
    %计算适应值
    preP  = zeros(populationNumber,1);
    for i=1:populationNumber
         %temp=reshape(PopulationMat(i, : ),4,20)';
         temp=reshape(PopulationMat(i, : ),20,4);
         for j =1:20
            result0(j, : )=temp(j, : );
         end
        %preP(i)=calculate_fitness(result0,coord,reward,max_class,0); 
        [tmpgrade, tmptrueFlag]= calculate_fitness(result0,coord,reward,max_class,0);
        %if ((i<=1)&&(iter<=1)) 
            %[tmpgrade, tmptrueFlag]= calculate_fitness(result0,coord,reward,max_class,1);
        %end
        preP(i) = tmpgrade;
        trueFlag(i) = tmptrueFlag;
        fitness(i)=preP(i);
        %if((preP(i) == 15)&&(iter==200)) 
           %calculate_fitness(result0,coord,reward,max_class,2);
           %[tmpgrade, tmptrueFlag]= calculate_fitness(result0,coord,reward,max_class,2);
        %end
    end
    if(min(preP)<0)
        preP=preP-min(preP)+1;
    end
    p=preP/sum(preP);
       %% 每一代的最优值
     
    [iterBestValue,xx]=max(fitness);
    iterBestIndividuiality = PopulationMat(xx,: ); 
    
    %if bestValue<=iterBestValue
    if bestValue<=iterBestValue&&trueFlag(i)
        bestValue = iterBestValue;
        bestIndividuality = iterBestIndividuiality;
    end
    bestValueMat(iter) = bestValue;
    bestIndividuialityMat(iter, : ) = bestIndividuality;

    %% 选择
    PopulationMat = selectionFunction(PopulationMat,p,populationNumber);
    
    %% 交叉
    %PopulationMat = crossFunction(PopulationMat,80,populationNumber);
    [PopulationMat,exchangeNum] = crossFunction1(PopulationMat,80,populationNumber,cross_p);
    exchangeRate = exchangeNum/populationNumber;
    
    %% 变异
    %preP  = zeros(populationNumber,1);
    pm1 = pm0 + kpm*(cross_p - exchangeRate);
    %pm1 = pm;
    [PopulationMat,pmReal] = heteromorphosisFunction(PopulationMat,pm1,80,populationNumber);
     

    pmRealMat(iter) =pm1;
    %iter = iter+1;
   %disp(['当前迭代次数：',num2str(iter),'/',num2str(exchangeNum)]);
end
%disp(['GA time consuming：',num2str(toc),'GA ：pmReal:',num2str(mean(pmRealMat))]);
disp(['GA time consuming：',num2str(toc)]);
gradeMax = bestValue;
xMax = bestIndividuality;
gaTime = toc;
pmR = mean(pmRealMat);
if(ifPrint == 1)
    figure(1)
    plot(1:iterMax,bestValueMat,'Color',[1 0 0],'LineStyle','-','LineWidth',1)
    grid on;
    xlabel('迭代次数')
    ylabel('最优值')
    title('迭代次数与最优值关系图')
    disp('=======================')
end


