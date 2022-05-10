%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description: Compute weights from 2-1 norm regularization (group lasso)
% Solver is not included here. Please download it from 
% http://www.cs.ubc.ca/~murphyk/Software/L1CRF/index.html
% User needs to manually define groups
%
% Fea: feature matrix
% alpha: bounds to normalize different features
% lambda: tuning parameter which controls the importance of prior
%
% Author: Shaoting Zhang, shaoting@cs.rutgers.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function weights = GetWeightsLassoGroup(X, Y, lambda, groups)

    sumX = sum(X);
    weights = zeros(size(X,2),1);

    data_num = size(X,2);
    w = zeros(data_num,1);
    % groups = zeros(data_num,1);

    group_num = length(unique(groups(groups>0)));

    funObj_sub = @(w)GaussianLoss(w,X,Y);

    % Make Initial Value
    w_init = zeros(data_num,1);
    w_init = [w_init;zeros(group_num,1)];
    for g = 1:group_num
        w_init(data_num+g) = norm(w_init(groups==g));
    end

    % Make Objective and Projection Function
    funObj = @(w)auxGroupLoss(w,groups,lambda,funObj_sub);
    funProj = @(w)auxGroupL2Proj(w,groups);

    % Solve
    wAlpha = minConF_SPG(funObj,w_init,funProj);
    i=1;
    w(:,i) = wAlpha(1:data_num);
    w_init = w(:,i);
    weights = w;

end
