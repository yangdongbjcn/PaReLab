function [features, W, targets] = ICA(train_features, output_dimension, learning_rate, train_targets, region)


%Reshape the data points using the independent component analysis algorithm
%Inputs:
%	train_features	- Input features D * N
%	train_targets	- Input targets
%	output_dimension
%   learning_rate
%	region			- Decision region vector: [-x x -y y number_of_points]
%
%Outputs
%	features		- New features
%	targets			- New targets
%	W				- Reshape martix

[D,N] = size(train_features);

if (D < output_dimension),
   error('Output dimension cannot be larger than the input dimension')
end

%Whiten the data to zero mean and unit covariance
train_features = train_features - mean(train_features')'*ones(1,N);
[eigenvalue_matrix, eigenvector_matrix]	= eig(cov(train_features',1));
Aw = eigenvalue_matrix*inv(sqrtm(eigenvector_matrix));
train_features = Aw' * train_features;

%Move data to the range of [-1,1]
train_features = (train_features - min(train_features')'*ones(1,N))./((max(train_features') - min(train_features'))'*ones(1,N));
train_features = train_features*2-1;

%Find the weight matrix
W = randn(D);
for i = 1:N,
   y = train_features(:,i);
   phi = activation(y);
   dW = learning_rate*(eye(D) - phi*y')*W;
   
   %Break if algorithm diverges
   if (max(max(dW)) > 1e3),
       disp(['Algorithm diverged after ' num2str(i) ' iterations'])
       break
   end
   
   W = W + dW;   
   
   %If the algorithm converged, exit
   if (max(max(W)) < 1e-2),
       disp(['Algorithm converged after ' num2str(i) ' iterations'])
       break
   end
end

%Take only the most influential outputs
power = sum(abs(W)');
[m, in]	= sort(power);
W = W(in(D-output_dimension+1:D),:);

%Calculate new features
features = W * train_features;


%End ICA

function phi = activation(y)
%Activation function for ICA
%phi=(3/4)*y.^11+(25/4)*y.^9+(-14/3)*y.^7+(-47/4)*y.^5+(29/4)*y.^3;
phi = 0.5*y.^5 + 2/3*y.^7 + 15/2*y.^9 + 2/15*y.^11 - 112/3*y.^13 + 128*y.^15 - 512/3*y.^17;