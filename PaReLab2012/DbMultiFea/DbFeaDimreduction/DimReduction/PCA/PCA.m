function [features, UW, m, targets] = PCA(train_features, dimension, train_targets, region)

%Reshape the data points using the principal component analysis
%Inputs:
%	train_features	- Input features
%	train_targets	- Input targets
%	dimension		- Number of dimensions for the output data points
%	region			- Decision region vector: [-x x -y y number_of_points]
%
%Outputs
%	features		- New features
%	targets			- New targets
%	UW				- Reshape martix
%   m               - Original feature averages

[D,N] = size(train_features);

if (D < dimension),
   disp('Required dimension is larger than the data dimension.')
   disp(['Will use dimension ' num2str(D)])
   dimension = D;
end

%Calculate cov matrix and the PCA matrixes
m           = mean(train_features')';
S			= ((train_features - m*ones(1,N)) * (train_features - m*ones(1,N))');
[eigenvalue_matrix, eigenvector_matrix]	    = eig(S);
W			= eigenvalue_matrix(:,D-dimension+1:D)';
U			= S*W'*inv(W*S*W');

%Calculate new features
UW			= U*W;
features    = W*train_features;