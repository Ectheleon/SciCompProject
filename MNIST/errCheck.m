% error check 

predictedNum=mode(nearestNums); % take the number that appears the most
% as the predicted number. 
actaulNum=labels(testImNum);

[~,noOfTestIm]=size(actualNum); 



% accuracy 
test=actaulNum==predictedNum; % Logical output 
accMeas=sum(test)/noOfTestIm; % percentage correct 




% errors by a choice of norms??? 

if strcomp(user_input.norm,'Euclidean') 
    
    
elseif strcomp(user_input.norm,'Infinity')
       
else 
    
end 
        