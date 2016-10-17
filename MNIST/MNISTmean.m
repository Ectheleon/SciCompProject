%% Mean Calculator 
% This script calculated the mean image of the MNIST training set. 
Import_Images 
meanIm=reshape((mean(images'))',28,28);
imshow(meanIm) 






