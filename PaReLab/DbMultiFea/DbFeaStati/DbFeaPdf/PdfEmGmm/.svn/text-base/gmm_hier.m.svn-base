function feature_gmm = gmm_hier(gmm_group, C2, varargin)
	% gmm
    % gmm_group{i} feature_gmm
	% feature_gmm.weight 1*c
	% feature_gmm.mu d*c
	% feature_gmm.sigma d*d*c
	% iyangdong@sina.com
	%
	%
	%
    
    params = struct(...
        'maxloops', 200, ...
        'thr', 1e-5, ...
        'verbose', 0, ...
        'components', 3, ...
        'logging', 0, ...
        'init', 'fcm1' ...
        );

    % logging    
    if nargout>1
        params.logging = 1;
        varargout{1} = [];
    end
    params = getargs(params, varargin);   % Get Args 
    if nargout<2
        params.logging=0;
    end

    N = length(gmm_group);    % number of data
    C1 = length(gmm_group{1}.weight);
    D = size(gmm_group{1}.mu,1);
    
    % least data number
    t_num_free_params = D+D*(D+1)/2;
    t_num_limit = (t_num_free_params+1)*3*C1;
    t_each_gmm = 2*floor(t_num_limit/N);
    if t_each_gmm < 10
        t_each_gmm = 10;
    end
        
    
    % feature_nd
    feature_nd = [];
    for i = 1 : N
        t_gmm = gmm_group{i};
        t_points = [];
        for j = 1 : length(t_gmm.weight)
            t_mu = t_gmm.mu(:,j);
            t_sigma = t_gmm.sigma(:,:,j);
            r = mvnrnd(t_mu,t_sigma,t_each_gmm);
            t_points = [t_points; r];
        end
        feature_nd = [feature_nd; t_points];
    end
   
    cfg = [];
    [cluster_label, mix_mu ,real_cluster_num, rst] = nd_km(feature_nd, C2, cfg);
    init_gmm = nd_lbl_emgmm(feature_nd, cluster_label, cfg);

    % 
    weight_n2 = [];
    for i = 1 : N
        tmp1 = gmm_group{i}.weight';
        weight_n2 = [weight_n2; tmp1];
    end
    N2 = length(weight_n2);
    
    mu_dn2 = [];
    for i = 1 : N        
        tmp1 = gmm_group{i}.mu;        
        mu_dn2 = [mu_dn2 tmp1];
    end
    mu_n2d = mu_dn2';
    
    sigma_ddn2 = [];
    for i = 1 : N
        sigma_ddn2 = cat(3, sigma_ddn2, gmm_group{i}.sigma);
    end
    
    for i = 1 : C2
        isigma(:,:,i) = inv(init_gmm.sigma(:,:,i));
    end    
    
    % begin
    old_loglike = -realmax;
    
    loops=1;
        
    prob_n2c2 = uf_prob(init_gmm.mu, init_gmm.sigma, init_gmm.weight, mu_n2d, sigma_ddn2, isigma, weight_n2);
    
    while 1
        loops
        
        h_n2c2 = prob_n2c2 ./ (sum(prob_n2c2,2)*ones(1,C2));
        
        tmp = ~isfinite(h_n2c2);
        h_n2c2(tmp) = 0;
        
        cur_weight = single(sum(h_n2c2,1))./(N2);
        
        tmp1 = h_n2c2 .* (weight_n2 * ones(1,C2));
        h_weight = tmp1 ./ (ones(N2,1) * sum(tmp1, 1));
        cur_mu = mu_n2d' * h_weight;    % D*C2
        
        for c2 = 1 : C2
            tmp4 = zeros(D, D);
            for n2 = 1 : N2
                tmp1 = mu_n2d(n2, :)' - cur_mu(:, c2);
                tmp2 = tmp1 * tmp1';
                tmp3 = sigma_ddn2(:,:,n2) + tmp2;
                tmp4 = tmp4 + tmp3 * weight_n2(n2);
            end
            cur_sigma(:,:,c2) = tmp4 / (N2);
        end
        
        prob_n2c2 = uf_prob(cur_mu, cur_sigma, cur_weight, mu_n2d, sigma_ddn2, isigma, weight_n2);
        test_loglike = sum(log(sum(prob_n2c2, 2)));
        
        if (abs(test_loglike/old_loglike -1) < params.thr)
            break;
        end
        
        if loops >= params.maxloops
            break;
        end
        
        loops = loops +1;
        old_loglike = test_loglike;
    end
    
	%YCb
    tmp = ~isfinite(cur_mu);
    cur_mu(tmp) = 0;
    tmp = ~isfinite(cur_sigma);
    cur_sigma(tmp) = 0;
    tmp = ~isfinite(cur_weight);
    cur_weight(tmp) = 0;
    %/YCb

	feature_gmm.weight = cur_weight;
	feature_gmm.mu = cur_mu;
	feature_gmm.sigma = cur_sigma;
end

function prob_n2c2 = uf_prob(mu, sigma, weight, mu_n2d, sigma_ddn2, isigma, weight_n2)
    h_n2c2 = uf_norm(mu_n2d, mu, sigma, weight);
    exp_n2c2 = uf_exp(sigma_ddn2, isigma);
    prob_n2c2 = h_n2c2 .* exp_n2c2;
    
    C2 = size(isigma, 3);
    tmp1 = repmat(weight_n2, [1 C2]);
    prob_n2c2 = prob_n2c2 .^ tmp1;
end

function h_n2c2 = uf_norm(mu_n2d, mu, sigma, weight)
    C2 = length(weight);
    for i = 1 : C2
        try
            h_n2c2(:, i) = mvnpdf(mu_n2d, mu(:, i)', sigma(:,:,i));
        catch
            h_n2c2(:, i) = mvnpdf(mu_n2d, mu(:, i)');
        end
    end
    tmp = ~isfinite(h_n2c2);
    h_n2c2(tmp) = 0;
end

function exp_n2c2 = uf_exp(sigma_ddn2, isigma)
    C2 = size(isigma, 3);
    D = size(sigma_ddn2,1);
    N2 = size(sigma_ddn2,3);
    for i = 1 : C2
        for j = 1 : N2
            tmp1 = trace(sigma_ddn2(:,:,j) .* isigma(:,:,i));
            exp_n2c2(j, i) = exp(.5 * tmp1);
        end
    end    
    tmp = ~isfinite(exp_n2c2);
    exp_n2c2(tmp) = 0;
end
