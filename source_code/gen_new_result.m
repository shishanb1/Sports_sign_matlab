function  result1=gen_new_result(result0,max_class)
%result0：原来的参赛方案，是一个260*4的向量，每一个元素为0/1
%由一个初始解生成一个新的可行解
        indexi =  randi([1, 20],1) ;  % 看哪一行需要更换
        indexj =  randi([1, 20],1) ;  % 看哪一行需要更换
        total_numi = sum(result0,2);
        shift=20*(max_class-1);
        for i =1:1000
        if(total_numi(shift+indexi)==0&&total_numi(shift+indexj)==0)
            indexi =  randi([1, 20],1) ;  % 看哪一行需要更换
            indexj =  randi([1, 20],1) ;  % 看哪一行需要更换
        else
            break;
        end
        end
        result1=result0;
        result1(shift+indexi,1:4)=result0(shift+indexj,1:4);
        result1(shift+indexj,1:4)=result0(shift+indexi,1:4);%将第indexi学生所报项目和第indexj学生所报项目交换
end