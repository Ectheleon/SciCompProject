function [ V , Training_Feature] = intPCD( Training_Set , c)
% In order to use the PCD Feature function to work, it requires the value
%of V to be known. This function calculates V for a predefined
%Training_Set.

%Training feature is Training_Set under the appropriate transformation.
%c refers to the number of eigenvalues which will be used. 

    %construct the covariance matrix from the Training_Set
    cov = Training_Set * transpose(Training_Set);
    
    %identify eigenvalues and eigenvectors of cov matrix
    [ vecs, vals] = eig(cov);
    vals = diag(vals);
    
    %Find the indices corresponding to the 'c' eigenvalues of largest
    %magnitude
    [~, indices] = sort(abs(vals));
    
    %update the variable indices to only include these larger eigenvalues.
    indices = indices(1:c);
    
    %Assign to V the eigenvectors corresponding to these larger
    %eigenvalues.
    V= vecs(indices, :);
    
    %Finally, transform the original set 'Training_Set into the small
    %array 'Training_Feature' 
    Training_Feature = vecs'*Training_Set; 
    Training_Feature = flipud(Training_Feature);
    Training_Feature = Training_Feature(indices, :);
end

