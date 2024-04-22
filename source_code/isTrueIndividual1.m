function [flag,outTimes] = isTrueIndividual1(Individuality,m)

%temp=reshape(Individuality,20,4); 
temp = Individuality(1:20,1:m); %temp 为20*4 矩阵
total_numi = sum(temp,1); %列求和 
outTimes = 0;
%% 第一个约束
for i = 1:m
     %if((total_numi(i) > 2) ||(total_numi(i)<2)) %不满足哦每个班每个项目只能报2个人
      if(total_numi(i) > 2)  %不满足哦每个班每个项目只能报2个人
        flag = 0;
        outTimes = outTimes + total_numi(i)-2 ;
        return;
    end
end

%% 第二个约束
total_numi = sum(temp,2); %行求和 
for i = 1:20
     if(total_numi(i)>2) %不满足哦每个人最多只能报2个人
        flag = 0;
        outTimes = outTimes + total_numi(i)-2 ;
        return;
    end
end
flag=1;
return;

%