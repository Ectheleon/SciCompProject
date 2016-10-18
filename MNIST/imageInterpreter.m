function [ predictedNum, time_taken ] = imageInterpreter( trainSet, trainLabels, testIm, userInputs)
%This function is designed to received a 28*28 image of a number written in
%white on a background of black and figure out what that number is.

%trainSet refers to a 784*m matrix, where each row refers to an 28*28 image
%containing a number.

%trainLabels is a 1*m array, where the value of m must match that of
%trainSet. This vector contains the number values which apply to the images
%contained in trainSet.

%testIm is a 784*n matrix, where each row refers to a 28*28 image, which
%the function will then read an interpret. 

%The values which this function decides apply to each image in testIm will
%be stored in the output vector: 'label', which should be a vector of
%length n.

%userInputs is a structure which contains information as to which method
%imageInterpreter should use. 
%   userInputs.k should contain the value of k which is to be used in the k
%   nearest neighbor algorithm.

%   userInputs.method should contain a string which is the name of the
%   method to be used. Options include 'intensity' and 'PCD'.

%   If the method selected requires any additional information, this data
%   should be recording inside userInputs.c 


   % Initialisation
   
   %Determine method used, and set up method
    if strcmp(userInputs.method,'intensity')
       [mu,trainFt]=intInsty(trainSet); 
       
       %Intensity
       testIm=testIm-mu; 

    else 
       [V,trainFt]=intPCD(trainSet, userInputs.c); % needs edited 
        %An extra input is required for intPCD. I've called this input c for now. 
        
       % PCD 
       testIm=V'*testIm; % change to take acount of multiple images at once 
       %I don't have the shape of V correct yet.
    end 

    % Interpretation 
    
    start_clock = cputime;
    
    % Now send into knnsearch 
    [IDX,~]=knnsearch(trainFt',testIm','k',userInputs.k); % check correct usage 
    
    
    % IDX is the index of the k closest images in the training set. 
    % outputs the index of the k nearest neighbours in trainFT. 
    % We now identify the label of the k-nearest neighbours 

    
    predictedNum=mode(transpose(trainLabels(IDX))); % take the number that appears the most
    % as the predicted number. 
    
    stop_clock = cputime;
    
    time_taken = (stop_clock - start_clock)/size(testIm,2);
end

