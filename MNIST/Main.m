%% Main 

% user inputs 
method='intensity';  
k=7; 

%% Import the image files 
% imports images and labels into the working directory 
Import_Images
testIm=??; % some test image 

%% Initialisation
if strcmp(method,'intensity')
   [mu,trainFt]=intInsty(images);
else 
   [V,trainFt]=intPCD(images); % needs edited 
end 

%% Interpretation 

% Calculate the feature of the image 

if strcmp(method,'intensity') 
   % Intensity 
   testIm=testIm-mu; 
else 
   % PCD 
   testIm=V'*testIm; % change to take acount of multiple images at once 
end 

% Now send into knnsearch 
[IDX,~]=knnsearch(trainFT,testIm,'k'); % check correct usage 
% outputs the index of the k nearest neighbours in trainFT. 

% We now identify the label of the k-nearest neighbours 
nearestNums=label(IDX); % need to check how to extract properly 

predictedNum=mode(nearestNums); % take the number that appears the most
% as the predicted number. 

  
%% Measuring success of method 

% does the predicted number match the label of the test number

% 