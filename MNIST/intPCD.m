function [ V , Training_Feature] = intPCD( Training_Set , c)
% In order to use the PCD Feature function to work, it requires the value
%of V to be known. This function calculates V for a predefined
%Training_Set.

%Training feature is Training_Set under the appropriate transformation.
%c refers to the number of eigenvalues which will be used. 

    %construct the covariance matrix from the Training_Set
    cov = Training_Set * transpose(Training_Set);
    
    %identify eigenvalues and eigenvectors of cov matrix
    [ vecs, ~] = eig(cov);
    
    %Assign to V the last c eigenvectors, which based on the natural matlab
    %ordering should correspond to the eigenvalues of greatest magnitude.
    V= vecs(:, end-c+1:end);
   
    %Finally, transform the original set 'Training_Set into the small
    %array 'Training_Feature' 
    Training_Feature = V'*Training_Set; 
    %Training_Feature = flipud(Training_Feature);
    %Training_Feature = Training_Feature(indices, :);
end

