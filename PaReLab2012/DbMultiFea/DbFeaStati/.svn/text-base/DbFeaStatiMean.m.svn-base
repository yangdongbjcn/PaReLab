function result = DbFeaStatiMean(nd_cells, image_labels)
	if ~exist('cluster_num', 'var')
		cluster_num = 256;
	end

	if ~exist('sample_num', 'var')
		sample_num = 20000;
	end

	for i = 1 : length(nd_cells)
		new_cells{i} = mean(nd_cells{i}, 1);
	end
    result{1} = new_cells;
end