function result = DbFeaStatiGmmVec(nd_cells, image_labels, cluster_num)

	if ~exist('cluster_num', 'var')
		cluster_num = 8;
	end
	
    for ii = 1 : length(nd_cells)
        data_nd = nd_cells{ii};
        gm = nd2gm(data_nd, cluster_num);
		gmm_cells{ii} = gm;		
		
		gmm_nd_cells{ii} = TransToGmmCd(gm);
    end
	
	result{1} = gmm_nd_cells;
	result{2} = gmm_cells;
end