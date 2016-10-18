%% Main 

% user inputs 

user_inputs.method='intensity';  
user_inputs.k=5; 
trainingSetSize=200; % number of images in the training set 

%For the PCD method, it must be predefined in advance how many eigenvalues
%will be used (as opposed to ignored). This value is stored in the variable c.

testImNum=5001:5021; % the index of the test image
NumOfTestIm=21; % number of test images 
user_inputs.c = 13;


%% Import the image files 
% imports images and labels into the working directory 
images = loadMNISTImages('train-images.idx3-ubyte');
labels = loadMNISTLabels('train-labels.idx1-ubyte');
 
%test_images = loadMNISTImages('t10k-images.idx3-ubyte');
%test_labels = loadMNISTLabels('t10k-labels.idx1-ubyte');


testIm=images(:,testImNum); % some test image 
trainSet=images(:,1:trainingSetSize); % training set 
trainLabels=labels(1:testImNum); % traingin labels 


%% Initialisation
if strcmp(user_inputs.method,'intensity')
   [mu,trainFt]=intInsty(trainSet); 
else 
   [V,trainFt]=intPCD(trainSet, user_inputs.c); % needs edited 
	%An extra input is required for intPCD. I've called this input c for now. 
end 

%% Interpretation 
[predictedNum,time]=imageInterpreter(trainSet,trainLabels,testIm,user_inputs);

%% Measuring success of method 

actualNum=labels(testImNum);
[m,~]=size(predictedNum); 

% accuracy 
test=actualNum==predictedNum; % Logical output 
accMeas=sum(test)/m % percentage correct 



