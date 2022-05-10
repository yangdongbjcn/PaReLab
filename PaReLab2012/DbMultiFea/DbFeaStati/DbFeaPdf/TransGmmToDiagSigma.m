function gm_diag = TransGmmToDiagSigma(gm)
	for i = 1 : gm.NComponents
        t_sigma(1, :, i) = diag(gm.Sigma(:,:,i));
    end
    gm_diag = gmdistribution(gm.mu, t_sigma, gm.PComponents);
end