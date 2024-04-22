%% ����һ���
clear;clc
coord=readmatrix('grade.xlsx');
coord1=coord';
rng('shuffle');
m = size(coord,2);  % �ܵı�����Ŀ��Ŀ
n = size(coord,1);  % ������Ա����Ŀ
class_num = 13; % �ܵİ༶��Ŀ
class_people_num=20;  %  ÿ���༶����

max_reward = 0;
reward = zeros(n,1); 
reward(1:8,1) = [9 7 6 5 4 3 2 1 ];  % ���μƷ�
%w=[6 3 2 1];
w=[13.0 25.0 58.0 200.0];
for i =1:4
     coord1(i,1:n)=coord1(i,1:n)/w(i);
end

max_val = -inf;
%c = [66.8 75.6 87 58.6 57.2 66 66.4 53 78 67.8 84.6 59.4 70 74.2 69.6 57.2 67.4 71 83.8 62.4]';  % Ŀ�꺯����ϵ���������к��е�д����
intcon = [1:n*m];  % ����������λ��(һ��n*m�����߱�������Ϊ0-1��������)
%c =  -ones(n*m,1);
c =reshape(coord1,n*m,1);
% ���Բ���ʽԼ����ϵ������ͳ�����������ÿλ��Ա���μ�2����Ŀ��һ��n��Լ����
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
% ���Ե�ʽԼ����ϵ������ͳ��������� ��ÿ����Ŀ���ҽ���class_num*2�˲μӣ�һ��m/�ĸ�Լ����
%Aeq = [1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0;
%          0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0;
%         0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0;
%         0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1];
%Aeq = [eye(4),eye(4),eye(4),eye(4),eye(4)];  % ����д�� repmat(eye(4),1,5)
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
lb = zeros(n*m,1);  % Լ�������ķ�Χ����
ub = ones(n*m,1);  % Լ�������ķ�Χ����
%������intlinprog()����
[x,fval] = intlinprog(c,intcon,A,b,Aeq,beq,lb,ub);
y=reshape(x,4,260);
xlswrite('x0.xlsx',y');


