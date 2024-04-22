function PopulationMat = selectionFunction(PopulationMat,p,populationNumber)

temporaryPopulationMat = PopulationMat;

for k1 = 1:populationNumber
    mid1 = rand;
    for k2 = 1:populationNumber
        mid1 = mid1-p(k2);
        if mid1<= 0
            PopulationMat(k1,:) = temporaryPopulationMat(k2,:);
            break;
        end
    end
end

%pp = [0;p];

%for k1 = 1:populationNumber
    %mid1 = rand;
    %for k2 = 1:size(pp,1)-1
        %if mid1>pp(k2) &&  mid1<pp(k2+1)
            %PopulationMat(k1,:) = temporaryPopulationMat(k2,:);
            %break;
        %end
    %end
%end
            