function  result1=gen_new_result(result0,max_class)
%result0��ԭ���Ĳ�����������һ��260*4��������ÿһ��Ԫ��Ϊ0/1
%��һ����ʼ������һ���µĿ��н�
        indexi =  randi([1, 20],1) ;  % ����һ����Ҫ����
        indexj =  randi([1, 20],1) ;  % ����һ����Ҫ����
        total_numi = sum(result0,2);
        shift=20*(max_class-1);
        for i =1:1000
        if(total_numi(shift+indexi)==0&&total_numi(shift+indexj)==0)
            indexi =  randi([1, 20],1) ;  % ����һ����Ҫ����
            indexj =  randi([1, 20],1) ;  % ����һ����Ҫ����
        else
            break;
        end
        end
        result1=result0;
        result1(shift+indexi,1:4)=result0(shift+indexj,1:4);
        result1(shift+indexj,1:4)=result0(shift+indexi,1:4);%����indexiѧ��������Ŀ�͵�indexjѧ��������Ŀ����
end