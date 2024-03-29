function [data_nr, trans_mat_dr] = ndDimReduction(data_nd, dim, cfg)
    %
    % yangdongbjcn@hotmail.com
    %
    % (C) Laurens van der Maaten, 2010 
    %
	
    cfgs = {'Pca', 'PcaShao', 'Ica', 'MDS', 'Isomap', 'Kernal PCA', 'Diffusion maps', 'LLE', 'Laplacian Eigenmaps', 'Hessian LLE', 'LTSA', 'MVU'};
    
	if ~exist('cfg', 'var')
		cfg = cfgs{2};
    end
    
    trans_mat_dr = ones(size(data_nd, 2), dim);
	
    switch cfg
        case 'Pca'
            data_nr = ndPcaWrapper(data_nd, dim);
        case 'PcaShao'
            [data_nr, trans_mat_dr] = ndPcaShaoWrapper(data_nd, dim);
        case 'Ica'
            data_nr = ndIcaWrapper(data_nd, dim);
        case 'MDS'
            data_nr = mds(data_nd, dim);
        case 'Isomap'
            data_nr = isomap(data_nd, dim);     % n ~= n
        case 'Kernal PCA'
            data_nr = kernel_pca(data_nd, dim);
        case 'Diffusion maps'
            data_nr = diffusion_maps(data_nd, dim, 25, 1);  
        case 'LLE'
            data_nr = lle(data_nd, dim);        % n ~= n
        case 'Laplacian Eigenmaps'
            data_nr = laplacian_eigen(data_nd, dim);
        case 'Hessian LLE'
            data_nr = hlle(data_nd, dim);       % error
        case 'LTSA'
            data_nr = ltsa(data_nd, dim);       % error
        case 'LLC'
            data_nr = llc(data_nd, neighbor, dim);  % error
        case 'MVU'
            data_nr  = fastmvu(data_nd, dim);       % error
    end
end
