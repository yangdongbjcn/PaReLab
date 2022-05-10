%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: Compute weights from L1 regularization (lasso)
% Solver is from http://www.cs.ubc.ca/~schmidtm/Software/lasso.html
% "Shooting" is used here. More solvers are available.
%
% Fea: feature matrix
% alpha: bounds to normalize different features
% lambda: tuning parameter which controls the importance of prior
%
% Author: Shaoting Zhang, shaoting@cs.rutgers.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function weights = GetWeightsLasso(X, Y, lambda)

    % weights = LassoGaussSeidel(X,Y,lambda,'verbose',0);
    weights = LassoShooting(X,Y,lambda,'verbose',0);    
end