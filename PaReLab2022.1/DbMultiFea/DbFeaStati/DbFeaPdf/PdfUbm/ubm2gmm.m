function [gmm, loglike, n_k, pi_k] = ubm2gmm(ubm, x_nd, cfg, max_iters, error_thres, r, alpha, avoid_non_psd)
		
	if ~exist('max_iters', 'var')
		max_iters = 200;
    end
    
	if ~exist('error_thres', 'var')
		error_thres = 1e-6;
    end
	
	if ~exist('r', 'var')
		r = 16;
	end
    
	if ~exist('alpha', 'var')
		alpha = 0.5;
    end
    
    if ~exist('avoid_non_psd', 'var')
		avoid_non_psd = 1e-12;
    end
	
	N = size(x_nd, 1);
	D = size(x_nd, 2);
	K = ubm.NComponents;

	gmm = zeroPGmdistribution(ubm.mu, ubm.Sigma, ubm.PComponents);
		
	i = 0;
    
	old_loglike = -realmax;
	
	while ( 1 )
		i = i + 1;
		
		[p_nk, loglike(i)] = eStep(gmm, x_nd);
		
        if (i > max_iters) | (abs(loglike(i)/old_loglike-1) < error_thres)
            break;
        end
		
		[gmm, n_k(i, :), pi_k(i, :)] = mStepAndUpdate(gmm, p_nk, x_nd, cfg, r, alpha, avoid_non_psd);
		
		old_loglike	= loglike(i);
	end
end

function [p_nk, loglike] = eStep(gmm, x_nd)
	% gmm, x_nd

	p_nk = ZeroPCluster(gmm, x_nd);
	loglike = sum(log(zeroPPdf(gmm, x_nd)));
	
	% p_nk, loglike
end

function [gmm_new, n_k, pi_k] = mStepAndUpdate(gmm, p_nk, x_nd, cfg, r, alpha, avoid_non_psd)
	% p_nk, x_nd	
	N = size(x_nd, 1);
	D = size(x_nd, 2);
	K = size(p_nk, 2);

	n_k = sum(p_nk, 1);
	
	switch lower(cfg)
		case {'sc', 'scmu'}
			pi_k = mStepPikSparseUbm(n_k, N, alpha);
		case {'p', 'pmu', 'all'}
			pi_k = mStepPikUbm(n_k, N);
	end

	switch lower(cfg)
		case {'mu', 'pmu', 'scmu', 'all'}		
			mu_dk = mStepMudk(p_nk, x_nd, n_k);
	end
	
	switch lower(cfg)
		case {'all'}			
			sigma_dk = mStepSigmadk(p_nk, x_nd, n_k);
	end
	% K, n_k, mu_dk, sigma_dk
		
	% gmm, n_k, pi_k, mu_dk, sigma_dk		
	%D = size(mu_dk, 1);

	alpha_k = n_k ./ (n_k + r);
	alpha_dk = repmat(alpha_k, D, 1);

	old_pi_k = gmm.PComponents;
	old_mu_dk = gmm.mu';
	old_sigma_dk = squeeze(gmm.Sigma); % diagonal covar

	switch lower(cfg)
		case {'sc', 'p', 'pmu', 'scmu', 'all'}
			new_pi_k = updateGmmPik(alpha_k, pi_k, old_pi_k);
	end

	switch lower(cfg)
		case {'mu', 'pmu', 'scmu', 'all'}
			new_mu_dk = updateGmmMudk(alpha_dk, mu_dk, old_mu_dk);
	end

	switch lower(cfg)
		case {'all'}
			new_sigma_dk = updateGmmSigmadk(alpha_dk, sigma_dk, old_sigma_dk, new_mu_dk, old_mu_dk);
			new_sigma_dk = fixSigma(new_sigma_dk, avoid_non_psd);
	end

	% new_pi_k, new_mu_dk, new_sigma_dk
	switch lower(cfg)
		case {'sc', 'p'}
			gmm_new = zeroPGmdistribution(gmm.mu, gmm.Sigma, new_pi_k);
		case {'mu'}
			gmm_new = zeroPGmdistribution(new_mu_dk', gmm.Sigma, gmm.PComponents);
		case {'pmu', 'scmu'}
			gmm_new = zeroPGmdistribution(new_mu_dk', gmm.Sigma, new_pi_k);
		case {'all'}
			sigma_1dk = permute(new_sigma_dk, [3 1 2]);
			gmm_new = zeroPGmdistribution(new_mu_dk', sigma_1dk, new_pi_k);
	end
end

function pi_k = mStepPikUbm(n_k, N)
	K = length(n_k);	
	pi_k = n_k / N;
end

function pi_k = mStepPikSparseUbm(n_k, N, alpha)
	K = length(n_k);	
	pi_k = (n_k + alpha-1) / (N + K * (alpha-1));
    
    pi_k(pi_k < 0) = 0;
    pi_k = pi_k / sum(pi_k);
end

function mu_dk = mStepMudk(p_nk, x_nd, n_k)
	D = size(x_nd, 2);
	K = size(p_nk, 2);

	p_dkn = permute(repmat(p_nk, [1 1 D]), [3 2 1]);
	n_dk = repmat(n_k, [D, 1]);
	x_dkn = permute(repmat(x_nd, [1 1 K]), [2 3 1]);

	mu_dk = sum(p_dkn .* x_dkn, 3) ./  n_dk; % S.mu(j,:) = post(:,j)' * X / S.PComponents(j);
	mu_dk(isnan(mu_dk)) = 0;
end

function sigma_dk = mStepSigmadk(p_nk, x_nd, n_k)
	D = size(x_nd, 2);
	K = size(p_nk, 2);
	p_dkn = permute(repmat(p_nk, [1 1 D]), [3 2 1]);
	n_dk = repmat(n_k, [D, 1]);

	x2_nd = x_nd.^2;%diag(x_nd * x_nd');
	x2_nkd = permute(repmat(x2_nd, [1 1 K]), [2 3 1]);
	sigma_dk = sum(p_dkn .* x2_nkd, 3) ./ n_dk; % S.Sigma(:,:,j) = post(:,j)' * (Xcentered.^2) /S.PComponents(j) +regVal;
	sigma_dk(isnan(sigma_dk)) = 0;
end

function new_pi_k = updateGmmPik(alpha_k, pi_k, old_pi_k)
	temp_pi_k = alpha_k .* pi_k + (1 - alpha_k) .* old_pi_k;
	new_pi_k = temp_pi_k / sum(temp_pi_k);
end

function new_mu_dk = updateGmmMudk(alpha_dk, mu_dk, old_mu_dk)
	new_mu_dk = alpha_dk .* mu_dk + (1 - alpha_dk) .* old_mu_dk;
    %assert(sum(new_mu_dk) == 1);
    %new_mu_dk = new_mu_dk / sum(new_mu_dk);
end

function new_sigma_dk = updateGmmSigmadk(alpha_dk, sigma_dk, old_sigma_dk, new_mu_dk, old_mu_dk)
	new_mu2_dk = new_mu_dk.^2;
	old_mu2_dk = old_mu_dk.^2;
	new_sigma_dk = alpha_dk .* sigma_dk + (1 - alpha_dk) .* (old_sigma_dk + old_mu2_dk) - new_mu2_dk;
end

function new_sigma_dk = fixSigma(sigma_dk, avoid_non_psd)
	% avoid_non_psd, sigma_dk
	
	new_sigma_dk = sigma_dk;
	% avoid non pos-semi-def
	new_sigma_dk(new_sigma_dk(:) < avoid_non_psd) = avoid_non_psd;
	for j = 1:K
		min_allowed = max(new_sigma_dk(:,j)) * eps;
		new_sigma_dk(new_sigma_dk(:,j) < min_allowed, j) = min_allowed;
	end
	
	% new_sigma_dk
end

function gm = zeroPGmdistribution(mu, Sigma, p)
    gm.mu = mu;
    if size(Sigma, 1) ~= 1
        for i = 1 : size(Sigma, 3)
            gm.Sigma(1, : , i) = diag(Sigma(:, :, i));
        end
    else
        gm.Sigma = Sigma;
    end
    gm.PComponents = p;
end

function prob = zeroPPdf(gmm, x_nd)
    nz_idx = find(gmm.PComponents ~= 0);
    p_nz = gmm.PComponents(nz_idx);
    mu_nz = gmm.mu(nz_idx, :);
    Sigma_nz = gmm.Sigma(1, :, nz_idx);
    gmm_nz = gmdistribution(mu_nz, Sigma_nz, p_nz);
    prob = pdf(gmm_nz, x_nd);
end