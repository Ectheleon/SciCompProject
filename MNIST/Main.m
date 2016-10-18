%% Main 

% user inputs 
method='intensity';  
k=15; 
trainingSetSize=5000; % number of images in the training set 
%For the PCD method, it must be predefined in advance how many eigenvalues
%will be used (as opposed to ignored). This value is stored in the variable c.
testImNum=5001; % the index of the test image
c = 13;

%% Import the image files 
% imports images and labels into the working directory 
Import_Images
testIm=images(:,testImNum); % some test image 
trainSet=images(:,1:trainingSetSize); % training set 
size(trainSet)

%% Initialisation
if strcmp(method,'intensity')
   [mu,trainFt]=intInsty(trainSet); 
else 
   [V,trainFt]=intPCD(trainSet, c); % needs edited 
	%An extra input is required for intPCD. I've called this input c for now. 
end 

%% Interpretation 

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

[IDX,S]=knnsearch(trainFt',testIm','k',k); % check correct usage 
% IDX is the index of the k closest images in the training set. 

% outputs the index of the k nearest neighbours in trainFT. 

% We now identify the label of the k-nearest neighbours 
nearestNums=labels(IDX) % need to check how to extract properly 

predictedNum=mode(nearestNums) % take the number that appears the most
% as the predicted number. 
actaulNum=labels(testImNum)
  
%% Measuring success of method 

% does the predicted number match the label of the test number

% actual label 

% 
