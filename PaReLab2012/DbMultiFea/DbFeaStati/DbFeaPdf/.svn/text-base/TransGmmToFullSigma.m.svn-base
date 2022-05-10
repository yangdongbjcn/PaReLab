function gm_diag = TransGmmToFullSigma(gm)
	for i = 1 : gm.NComponents
        t_sigma(:, :, i) = diag(gm.Sigma(1,:,i));
    end
    gm_diag = gmdistribution(gm.mu, t_sigma, gm.PComponents);
end