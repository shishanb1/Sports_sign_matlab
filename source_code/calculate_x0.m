%% 问题一求解
clear;clc
coord=readmatrix('grade.xlsx');
coord1=coord';
rng('shuffle');
m = size(coord,2);  % 总的比赛项目数目
n = size(coord,1);  % 参赛队员的数目
class_num = 13; % 总的班级数目
class_people_num=20;  %  每个班级人数

max_reward = 0;
reward = zeros(n,1); 
reward(1:8,1) = [9 7 6 5 4 3 2 1 ];  % 名次计分
%w=[6 3 2 1];
w=[13.0 25.0 58.0 200.0];
for i =1:4
     coord1(i,1:n)=coord1(i,1:n)/w(i);
end

max_val = -inf;
%c = [66.8 75.6 87 58.6 57.2 66 66.4 53 78 67.8 84.6 59.4 70 74.2 69.6 57.2 67.4 71 83.8 62.4]';  % 目标函数的系数矩阵（先列后行的写法）
intcon = [1:n*m];  % 整数变量的位置(一共n*m个决策变量，均为0-1整数变量)
%c =  -ones(n*m,1);
c =reshape(coord1,n*m,1);
% 线性不等式约束的系数矩阵和常数项向量（每位队员最多参加2个项目，一共n个约束）
%A = [1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
%      0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0;
%       0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0;
%      0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0;
%       0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1];
A = zeros(n,n*m);
for i = 1:n
    A(i, (m*i-m+1): m*i) = 1;
end
b = 2*ones(n,1);
% 线性等式约束的系数矩阵和常数项向量 （每个项目有且仅有class_num*2人参加，一共m/四个约束）
%Aeq = [1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0;
%          0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0;
%         0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0;
%         0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1];
%Aeq = [eye(4),eye(4),eye(4),eye(4),eye(4)];  % 或者写成 repmat(eye(4),1,5)
%Aeq=repmat(eye(4),1,n);
%beq = class_num *2*ones(m,1);
Aeq = zeros(class_num *4,n*m);
for i = 1:class_num
 %   Aeq=repmat(eye(4),(i-1)*class_people_num-1,i*class_people_num);
    shifti=4*(i-1);
    shiftj=shifti*class_people_num;
    for j =1:class_people_num
         Aeq(shifti+1, 4*j-3+shiftj) = 1;
         Aeq(shifti+2, 4*j-2+shiftj) = 1;
         Aeq(shifti+3,  4*j-1+shiftj) = 1;
         Aeq(shifti+4,  4*j+shiftj) = 1;
    end        
end
beq = 2*ones(m*class_num,1);
lb = zeros(n*m,1);  % 约束变量的范围下限
ub = ones(n*m,1);  % 约束变量的范围上限
%最后调用intlinprog()函数
[x,fval] = intlinprog(c,intcon,A,b,Aeq,beq,lb,ub);
y=reshape(x,4,260);
xlswrite('x0.xlsx',y');


