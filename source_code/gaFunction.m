%������Ŵ��㷨���
function [gradeMax,xMax,gaTime,pmR] = gaFunction(pm0,kpm,iterMax,ifPrint)
%function [gradeMax,xMax,gaTime,pmR] = gaFunction(pm0,kpm,iterMax)
%% ��ձ���
%clear
%clc
tic
gradeMax = 0;
gaTime = 0;

%% �Ŵ��㷨����˶��ᱨ������  % 
rng('shuffle')  % ��������������ɣ�����ÿ�δ�matlab�õ��Ľ����һ��
coord=readmatrix('grade.xlsx');
m = size(coord,2);  % �ܵı�����Ŀ��Ŀ
n = size(coord,1);  % ������Ա����Ŀ
class_num = 13; % �ܵİ༶��Ŀ

max_class = 1; % ��Ҫ�Ż��ĵİ༶

max_grade = 0;
reward  = zeros(n,1); 
reward(1:8,1) = [9 7 6 5 4 3 2 1 ];  % ���μƷ�
w=[6 3 2 1];

%function[xmax,pmax,pmax_t ]=gaknaps(c1,p1,m1)
%[xmax,pmax]=gaknaps(cl,pl,m1)
%cl pl are raw vectors
%ml is the 1imit
%tic;
%���û���λ��
%num=size(c1,2);
num=m*n/class_num; %���û���λ��=20*4


populationNumber = 50; %��Ⱥ��ģ��С populationNumber
PopulationMat = zeros(populationNumber,1);

PopulationValue=rand(populationNumber,num)>0.5;
%��ǰ��������
%��ǰ���Ž�ļ�ֵ
pmax=0;
pmax_t=0;
%��������
cross_p=0.8;
%�������
%pm = 0.6;
%pm = pm_set;
%�ܵ�������
%iterMax = 1000; %1000�ܵ�������
%iterMax = iter_set; %�ܵ�������
bestValue = -inf;  %��ʼ���ҵ�����ѵĽ��Ӧ�ĵ÷�
bestValueMat = zeros(iterMax,1);    %ÿ�ε���������ֵ����
bestIndividuialityMat = zeros(iterMax,80);

iter = 0;
max_grade = 0;     % ��ʼ���ҵ�����ѵĽ��Ӧ�ĵ÷�Ϊgrade0
result0 =readmatrix('x0.xlsx') %��ʼ�⣬��������0-1�滮�Ľ��
%tempy = result0(1:20,1:4)';
tempy = result0(1:20,1:4);
PopulationValue(1, : )=reshape(tempy,1,80)';%��ʼ�⣬��ֵ����һ������
%��ʼ����Ⱥ
currPopuNum = 1;
%% ��ʼ������
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
    %����������λ��Ϊ0������������
    for i=1:populationNumber
        if PopulationMat(i, : )==0
            PopulationMat(i, : )=-1-PopulationMat(i, : );
            disp('erro');
        end
    end
    %������Ӧֵ
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
       %% ÿһ��������ֵ
     
    [iterBestValue,xx]=max(fitness);
    iterBestIndividuiality = PopulationMat(xx,: ); 
    
    %if bestValue<=iterBestValue
    if bestValue<=iterBestValue&&trueFlag(i)
        bestValue = iterBestValue;
        bestIndividuality = iterBestIndividuiality;
    end
    bestValueMat(iter) = bestValue;
    bestIndividuialityMat(iter, : ) = bestIndividuality;

    %% ѡ��
    PopulationMat = selectionFunction(PopulationMat,p,populationNumber);
    
    %% ����
    %PopulationMat = crossFunction(PopulationMat,80,populationNumber);
    [PopulationMat,exchangeNum] = crossFunction1(PopulationMat,80,populationNumber,cross_p);
    exchangeRate = exchangeNum/populationNumber;
    
    %% ����
    %preP  = zeros(populationNumber,1);
    pm1 = pm0 + kpm*(cross_p - exchangeRate);
    %pm1 = pm;
    [PopulationMat,pmReal] = heteromorphosisFunction(PopulationMat,pm1,80,populationNumber);
     

    pmRealMat(iter) =pm1;
    %iter = iter+1;
   %disp(['��ǰ����������',num2str(iter),'/',num2str(exchangeNum)]);
end
%disp(['GA time consuming��',num2str(toc),'GA ��pmReal:',num2str(mean(pmRealMat))]);
disp(['GA time consuming��',num2str(toc)]);
gradeMax = bestValue;
xMax = bestIndividuality;
gaTime = toc;
pmR = mean(pmRealMat);
if(ifPrint == 1)
    figure(1)
    plot(1:iterMax,bestValueMat,'Color',[1 0 0],'LineStyle','-','LineWidth',1)
    grid on;
    xlabel('��������')
    ylabel('����ֵ')
    title('��������������ֵ��ϵͼ')
    disp('=======================')
end


