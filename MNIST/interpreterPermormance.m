function [ accMeas ] = interpreterPermormance( predictedNum,  trueNum)
%This function takes as input the prediction made by imageInterpreter as to
%what numbers apply to a set of images, in addition to the actual answer. 

%Then the predicition is compared to the truth. The precentage accuracy is
%then outputted from the function.
    
    % accuracy 
    test=trueNum==predictedNum; % Logical output 
    accMeas=sum(test)/NumOfTestIm; % percentage correct 
end

