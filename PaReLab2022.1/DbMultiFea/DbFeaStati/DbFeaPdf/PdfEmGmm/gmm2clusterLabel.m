function cluster_label = gmm2clusterLabel(feature_nd, weight, mu, sigma)
    % gmm
	% weight 1*c
	% mu c*d
	% sigma d*d*c
	% 
	% yangdongbjcn@hotmail.com
	% Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    N = size(feature_nd, 1);
    C = size(mu, 2); 

    t_pdf = zeros(N,C);
    for c = 1:C
        tmp1 = single(feature_nd);
        tmp2 = single(mu(c,:));
        tmp3 = gmmb_covfixer(sigma(:,:,c));
        tmp3 = single(tmp3);
        t_pdf(:,c) = weight(c) * mvnpdf(tmp1, tmp2, tmp3);
        %t_pdf(:,c) = mvnpdf(tmp1, tmp2, tmp3);
    end
    
    %YCb
    tmp = ~isfinite(t_pdf);
    t_pdf(tmp) = 0;
    %/YCb
    
    [t_max cluster_label] = max(t_pdf, [], 2);
end

function x = fixInfinite(x)
    tmp = ~isfinite(x);
    x(tmp) = 0;
end