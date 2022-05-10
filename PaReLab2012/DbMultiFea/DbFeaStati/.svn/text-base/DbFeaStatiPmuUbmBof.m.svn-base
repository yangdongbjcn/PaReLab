function result = DbFeaStatiPmuUbmBof(nd_cells, image_labels, cluster_num, sample_num, data_format, zoom_size)
	
	result = DbFeaStatiUbm(nd_cells, image_labels, cluster_num, sample_num, 'pmu');
	UBM = result{1};
	gmm_cells = result{2};
	
	for i = 1 : length(nd_cells)
		gm = gmm_cells{i};
		data_nd = nd_cells{i};
		
        % post
		% pdf_nc = pdf(gm, data_nd);
        pdf_nc = ZeroPCluster(gm, data_nd);
%         % conditional
%         gm = TransGmmToFullSigma(gm);
%         for c = 1:gm.NComponents
%             pdf_nc(:,c) = mvnpdf(data_nd, gm.mu(c, :), gm.Sigma(:,:,c));
%         end
%         pdf_nc(isnan(pdf_nc)) = 0;
		gmm_bof_cells{i} = sum(pdf_nc, 1);
	end
		
	result{1} = gmm_bof_cells;
	result{2} = UBM;
	result{3} = gmm_cells;
end