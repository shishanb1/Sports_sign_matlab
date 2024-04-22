function [PopulationMat,pmReal] = heteromorphosisFunction(PopulationMat,pm,maxBinary,populationNumber)

%binaryPopulationMat = decimalToBinaryMat(decimalPopulationMat,preci,maxBinary);
temporaryPopu = PopulationMat;
heteromorphosisNum = 0;
for k1 = 1:populationNumber
    %for k2 = 1:solveDegree
        if rand<pm
            heteromorphosisPoint = randi(maxBinary);
            preValue = PopulationMat(k1,heteromorphosisPoint);
            if preValue == 1
                nowValue = 0;
            else
                nowValue = 1;
            end
            PopulationMat(k1,heteromorphosisPoint) = nowValue;
            heteromorphosisNum = heteromorphosisNum + 1;
        end
    %end
end

tempPopulationMat =PopulationMat;

pmReal = 0;
%for k5 = 1:populationNumber
for k5 = 1:0 %populationNumber    
    %tempMat=reshape(tempPopulationMat(k5, : ),4,20)';
    tempMat=reshape(tempPopulationMat(k5, : ),20,4);
    if ~isTrueIndividual(tempMat,4)
        tempPopulationMat(k5,:) = temporaryPopu(k5,:);
        heteromorphosisNum = heteromorphosisNum - 1;
    end
end


PopulationMat = tempPopulationMat;
pmReal = heteromorphosisNum/populationNumber;

