function predictedNum = imageInterpreter( trainSet, trainLabels, testIm, user_inputs)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    method = user_inputs.method;

   % Initialisation
    if strcmp(method,'intensity')
       [mu,trainFt]=intInsty(trainSet); 
    else 
       [V,trainFt]=intPCD(trainSet, user_inputs.c); % needs edited 
        %An extra input is required for intPCD. I've called this input c for now. 
    end 

    % Interpretation 

    % Calculate the feature of the image 

    if strcmp(method,'intensity') 
       % Intensity 
       testIm=testIm-mu; 
    else 
       % PCD 
       testIm=V'*testIm; % change to take acount of multiple images at once 
        %I don't have the shape of V correct yet.
    end 

    % Now send into knnsearch 

    %In order to make k an input for knnsearch, you must first place the 
    %string 'k' in order to signal that you aren't merely using the default 
    %value. In addition though, you must define the value itself, which is
    %contained in the variable k as opposed to in the string 'k'.

    [IDX,~]=knnsearch(trainFt',testIm','k',user_inputs.k); % check correct usage 
    % IDX is the index of the k closest images in the training set. 

    % outputs the index of the k nearest neighbours in trainFT. 
    % We now identify the label of the k-nearest neighbours 
    nearestNums=trainLabels(IDX); % need to check how to extract properly 
    predictedNum = mode(nearestNums,2);
    
   
end

