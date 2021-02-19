function [sparse_gm, loglike] = SparseGmm(gm, data_nd, like_thres)

	if ~exist('like_thres', 'var')
		like_thres = 1e-6;
	end
	
	[N, D] = size(data_nd); %D is num vars
	
	data_md = data_nd;
		
	k = 1;
    
    w = zeros(size(gm.PComponents));
	
	while ( 1 )
	
        [idx, nlogl, postprob_nc] = cluster(gm, data_md);
    
        loglike(k) = sum(log(sum(postprob_nc, 2)));
	
		postprobsum_c1 = sum(postprob_nc, 1);
		
		[C, i_k] = max(postprobsum_c1);
		
		postprob_n1 = postprob_nc(:, i_k);
        
        w(i_k) = w(i_k) + length(find(postprob_n1 > like_thres));
		
		data_md(postprob_n1 > like_thres, :) = [];
		
        if ((k >= gm.NComponents) | isempty(data_md))
            break;
        end
		
		k = k + 1;
    end
    
    w = w / N;
	
	[sparse_gm] = transToGm(w, gm.mu, gm.Sigma);
end

function [sparse_gm] = transToGm(w_hat_i, mu_hat_vi, sigma2_hat_vi)
	% w_hat_i, mu_hat_vi, sigma2_hat_vi

	mu_hat_iv = mu_hat_vi';
	sigma2_hat_1vi = permute(sigma2_hat_vi, [3 1 2]);
	sparse_gm = gmdistribution(mu_hat_iv, sigma2_hat_1vi, w_hat_i);

	% sparse_gm
end