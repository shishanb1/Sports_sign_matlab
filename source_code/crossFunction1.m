   
function [PopulationMat,exchangeNum] = crossFunction1(PopulationMat,maxBinary,populationNumber,cross_p)

%binaryPopulationMat = decimalToBinaryMat(decimalPopulationMat,preci,maxBinary);
temporaryPopu = PopulationMat; %保留原始输入参数
Num = size(PopulationMat,1);
exchange = zeros(Num,1);
exchangeNum = 0;

for k1 = 1:Num*cross_p
    %for k2 = 1:solveDegree
    if  exchange(k1)==0
        for k2 = k1+1:Num
            gap = maxBinary-sum(PopulationMat(k1,: )==PopulationMat(k2,: ));
            if (exchange(k2)==0&& gap >0)
                mid1 = randi(maxBinary,1,2);
                crossStart = min(mid1);
                crossEnd = max(mid1);
                fatherGene = PopulationMat(k1,crossStart:crossEnd);
                %motherGene = PopulationMat(k1+1,crossStart:crossEnd);
                motherGene = PopulationMat(k2,crossStart:crossEnd);
                PopulationMat(k1,crossStart:crossEnd) = motherGene;
                %PopulationMat(k1+1,crossStart:crossEnd) = fatherGene;
                PopulationMat(k2,crossStart:crossEnd) = fatherGene;
                exchange([k1 k2])=1;
                exchangeNum = exchangeNum+1;
                break;
            end
    %end
        end
    end
end
 
tempPopulationMat = PopulationMat;
%for k3 = 1:size(decimalPopulationMat,1)
    %for k4 = 1:solveDegree
        %if temporaryPopu(k3,k4)<0
           % tempDecimalPopulationMat(k3,k4) = -tempDecimalPopulationMat(k3,k4);
        %end
    %end
%end
exchangeNum = exchangeNum + exchangeNum;
for k5 = 1:populationNumber
%tempMat=reshape(tempPopulationMat(k5, : ),4,20)';
tempMat=reshape(tempPopulationMat(k5, : ),20,4);
    if ~isTrueIndividual(tempMat,4)
    %if ~isTrueIndividual(PopulationMat(k5,:),4)
        tempPopulationMat(k5,:) = temporaryPopu(k5,:);
        exchangeNum = exchangeNum - 1;
    end
end


PopulationMat = tempPopulationMat;
