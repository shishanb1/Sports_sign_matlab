function flag = isTrueIndividual(Individuality,m)
%temp=reshape(Individuality,20,4); 
temp = Individuality(1:20,1:m); %temp Ϊ20*4 ����
total_numi = sum(temp,1); %����� 
%% ��һ��Լ��
for i = 1:m
     if((total_numi(i) > 2) ||(total_numi(i)<2)) %������Ŷÿ����ÿ����Ŀֻ�ܱ�2����
        flag = 0;
        return;
    end
end

%% �ڶ���Լ��
total_numi = sum(temp,2); %����� 
for i = 1:20
     if(total_numi(i)>2) %������Ŷÿ�������ֻ�ܱ�2����
        flag = 0;
        return;
    end
end
flag=1;
return;

%