function [mu,trainFt]=intInsty(images)
% Intensity Feature 
% This script calculated the mean image of the MNIST training set. 
mu=mean(images,2);
% Find the variance of each of the images 
trainFt=images-mu;
end 



