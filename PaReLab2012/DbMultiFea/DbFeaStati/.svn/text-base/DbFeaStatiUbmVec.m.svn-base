function result = DbFeaStatiUbmVec(nd_cells, image_labels, cluster_num, sample_num)
	
	result = DbFeaStatiUbm(nd_cells, image_labels, cluster_num, sample_num);
	UBM = result{1};
	gmm_cells = result{2};
	
	for i = 1 : length(nd_cells)
		gm = gmm_cells{i};
		
		gmm_nd = TransToGmmCd(gm);
		gmm_dn = gmm_nd';
		gmm_vec_cells{i} = gmm_dn(:)';
	end
		
	result{1} = gmm_vec_cells;
	result{2} = UBM;
	result{3} = gmm_cells;
end