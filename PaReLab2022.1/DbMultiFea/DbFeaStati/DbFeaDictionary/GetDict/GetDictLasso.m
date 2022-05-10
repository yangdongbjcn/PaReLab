function [dict_md, u_cn] = GetDictLasso(data_nd, dict_num)

	beta = 1e-5;                        % a small regularization for stablizing sparse coding
	gamma = 0.15;
	num_iters = 10;
    [B, S, stat] = reg_sparse_coding(data_nd, dict_num, eye(dict_num), beta, gamma, num_iters);
    
    dict_md = S;
    u_cn = B';
end