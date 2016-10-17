function [mu,trainFt]=intInsty(images)
% Intense Feature 
% This script calculated the mean image of the MNIST training set. 
meanIm=(mean(images'))';
% Find the variance of each of the images 
trainFt=images-meanIm;
end 



