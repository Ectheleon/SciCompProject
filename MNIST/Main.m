%% Main 

% user inputs 
cooperative_user = 0;
cooperation_count = 0;

while ~cooperative_user
    cooperation_count = cooperation_count+1;
    cooperative_user = 1;
    
    if cooperation_count > 1 && cooperation_count <5
       disp('Error, invalid input. Please try again and follow the given guidlines'); 
    elseif cooperation_count >= 5 && cooperation_count<10
       disp('Error, please follow instructions and stop causing trouble'); 
    elseif cooperation_count >=10
        disp('Just cut it out');
    end
    
    
    trainSize =inputdlg('How many images do you want to have in your training set? You should select an integer between 1 and 60,000. (Please cooperate .... or else)');
    trainSize = int64(str2double(trainSize{1}));
    
    if trainSize <1 || trainSize > 60000
        cooperative_user = 0; 
    else
        disp(['The first ' num2str(trainSize) ' images from the MNIST database will be used as the training set']);
    end


    testSize = inputdlg('How many images would you like to classify? Enter an integer between 1 and 10,000:');
    testSize = int64(str2double(testSize{1}));
    
    if testSize <1 || testSize > 10000
        cooperative_user = 0;
    else
        disp(['The first ' num2str(testSize) ' images from the MNIST test set images will be used as the test set']);
    end

    temp = inputdlg('What value of k do you want to be used for the k nearest neighbor algorithm? (Please pick a value less than 1000, as that would be overkill.)');
    user_inputs.k = int64(str2double(temp{1}));
    
    if user_inputs.k <1 ||user_inputs.k >1000
       cooperative_user = 0;
    end
    
    temp = inputdlg('Currently there are 2 identification methods built in: intensity, and PCA. Please input intensity to select intensity, or enter PCA to select PCA.');
    user_inputs.method = temp{1};
    
    if strcmp(user_inputs.method, 'PCA')
        temp = inputdlg('When using the PCA method, you must decide how many eigenvalues to keep. Please enter a number between 1 and 784');
        user_inputs.c = int64(str2double(temp{1}));
        
        if user_inputs.c<1 || user_inputs.c>784
           cooperative_user = 0; 
        end
    else
        user_inputs.c = 0;
    end
end

%user_inputs.method='intensity';  



%trainingSetSize=200; % number of images in the training set 

%For the PCD method, it must be predefined in advance how many eigenvalues
%will be used (as opposed to ignored). This value is stored in the variable c.

%testImNum=5001:5021; % the index of the test image
%NumOfTestIm=21; % number of test images 


%% Import the image files 
% imports images and labels into the working directory 
images = loadMNISTImages('train-images.idx3-ubyte');
labels = loadMNISTLabels('train-labels.idx1-ubyte');
 
test_images = loadMNISTImages('t10k-images.idx3-ubyte');
test_labels = loadMNISTLabels('t10k-labels.idx1-ubyte');


testIm=test_images(:,1:testSize); % some test image 
testAns = test_labels(1:testSize);



trainSet=images(:,1:trainSize); % training set 
trainLabels=labels(1:trainSize); % traingin labels 


%% Initialisation
if strcmp(user_inputs.method,'intensity')
   [mu,trainFt]=intInsty(trainSet); 
else 
   [V,trainFt]=intPCA(trainSet, user_inputs.c); % needs edited 
	%An extra input is required for intPCD. I've called this input c for now. 
end 

%% Interpretation 
[predictedNum,time]=imageInterpreter(trainSet,trainLabels,testIm,user_inputs);

%% Measuring success of method 


performance = interpreterPerformance(predictedNum, testAns);


disp(['Predictions were made for the ' num2str(testSize) ' images.']);
disp(['They were found with ' num2str(performance) ' accuracy.']);
disp(['The time taken by the image identification function was ' num2str(time) ' seconds.']);


