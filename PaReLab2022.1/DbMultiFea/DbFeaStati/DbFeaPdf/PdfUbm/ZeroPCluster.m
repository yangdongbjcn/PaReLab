function [p_nk, t] = ZeroPCluster(gmm, x_nd)
    tic;
    nz_idx = find(gmm.PComponents ~= 0);
    p_nz = gmm.PComponents(nz_idx);
    mu_nz = gmm.mu(nz_idx, :);
    Sigma_nz = gmm.Sigma(1, :, nz_idx);
    gmm_nz = gmdistribution(mu_nz, Sigma_nz, p_nz);
    [idx, nlogl, p_nk_nz] = cluster(gmm_nz, x_nd);
    p_nk = zeros(size(x_nd, 1), length(gmm.PComponents));
    p_nk(:, nz_idx) = p_nk_nz;
    t = toc;
end