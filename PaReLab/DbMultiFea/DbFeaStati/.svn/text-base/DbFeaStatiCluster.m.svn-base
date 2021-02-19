function result = DbFeaStatiCluster(nd_cells, image_labels, cluster_num)
	if ~exist('cluster_num', 'var')
		cluster_num = 8;
    end
    
    num_img = length(nd_cells);

	for ii = 1:num_img
		data_nd = nd_cells{ii};
		[data_label, center_cd] = KmeansDyang(data_nd, cluster_num, 500);
        new_cells{ii} = center_cd;
	end;

    result{1} = new_cells;
end