function weights = GetWeights(dict_md, data_1d, lambda, groups, regu_type)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    if ~exist('regu_type', 'var')
        regu_type = 1;
    end
    if ~exist('groups', 'var')
        groups = 1 : size(dict_md, 1);
    end
    
    dict_md = single(dict_md);
    data_1d = single(data_1d);
    
	% 0 -- JEC; 1 -- lasso; 2 -- group lasso; 5 -- Least Square; 
    % 6 -- L2 regularization
    switch regu_type 
		case 1
			weights = GetWeightsLasso(dict_md', data_1d', lambda);
		case 2
			weights = GetWeightsLassoGroup(dict_md', data_1d', lambda, groups);
		case 5
			weights = GetWeightsLeastSquare(dict_md', data_1d');
		case 6
			weights = GetWeightsL2Reg(dict_md', data_1d', lambda);
	end
end
