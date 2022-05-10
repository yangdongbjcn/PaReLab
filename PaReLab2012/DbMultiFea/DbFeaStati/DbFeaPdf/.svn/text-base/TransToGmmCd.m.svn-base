function gmm_nd = TransToGmmCd(gm)
	% for i = 1 : gm.NComponents
		% tmp1 = sqrtm(gm.Sigma(:,:,i));
		% tmp2 = inv(tmp1);
		% tmp3 = sqrt(gm.PComponents(i)/2) * tmp2 * gm.mu(i, :)';
		% gmm_nd(i, :) = tmp3';
	% end
	
	if size(gm.Sigma, 1) ~= 1
		gm = TransGmmToDiagSigma(gm);
	end
	
	t_mu = gm.mu';
	t_sigma = squeeze(gm.Sigma);
	t_sigma = t_sigma .^ (-.5);
	t_p = sqrt(gm.PComponents/2);
	t_p = ones(size(t_mu, 1), 1) * t_p;
	gmm_nd = t_mu .* t_sigma .* t_p;
	gmm_nd = gmm_nd';
end