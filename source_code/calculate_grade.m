
function grade = calculate_grade(result,coord,reward,max_class,first)
    result1 = coord .* result;
    result1(find(result1 ==0))=+inf;
    [result2,Index] = sort(result1);
    %max_class=13;
    if (first==1)
        xlswrite('firstx-0.xlsx',result);
        xlswrite('firstx-1.xlsx',result1);
        xlswrite('firstx-index.xlsx',Index);
        xlswrite('firstx-index-grade.xlsx',result2);
    end
    if (first==2)
        xlswrite('maxx-0.xlsx',result);
        xlswrite('maxx-1.xlsx',result1);
        xlswrite('max-index.xlsx',Index);
        xlswrite('max-index-grade.xlsx',result2);
    end
    total_grade = 0;
    for j =1:4
        for i = 1:8 %前8名才计分
            if reward(i)
                if Index(i,j)<=max_class*20
                    if Index(i,j)>(max_class-1)*20 %对应的学生属于所在班级max_class
                        total_grade = total_grade  + result(Index(i,j),j)*reward(i);
                    end
                end
            end
        end
    end
    grade = total_grade;
end