%% Main 

% user inputs 
method='intensity';  
k=7; 

%% Import the image files 
% imports images and labels into the working directory 
Import_Images
testIm=??; % some test image 

%For the PCD method, it must be predefined in advance how many eigenvalues
%will be used (as opposed to ignored). This value is stored in the variable c.

%c = 13;

%% Initialisation
if strcmp(method,'intensity')
   [mu,trainFt]=intInsty(images);
else 
   [V,trainFt]=intPCD(images, c); % needs edited 
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
[IDX,~]=knnsearch(trainFT,testIm,'k', k); % check correct usage 
% outputs the index of the k nearest neighbours in trainFT. 

% We now identify the label of the k-nearest neighbours 
nearestNums=label(IDX); % need to check how to extract properly 

predictedNum=mode(nearestNums); % take the number that appears the most
% as the predicted number. 

  
%% Measuring success of method 

% does the predicted number match the label of the test number

% 
