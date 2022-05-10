 function [train_cells_new, test_cells_new] = NormDataByMaxMinSum(train_cells, test_cells)
	[train_ndd, inst_len_train] = TransCellMatToCells(train_cells, 1);
	[test_ndd, inst_len_test] = TransCellMatToCells(test_cells, 1);
	
	for i = 1 : length(train_ndd)
		fea_mat = train_ndd{i};
        min_fea = min(fea_mat);
        max_fea = max(fea_mat);
        max_dist = max_fea - min_fea;
        alpha(i) = sum(max_dist);
		train_ndd{i} = train_ndd{i} / alpha(i);
	end
	
	for i = 1 : length(test_ndd)
		test_ndd{i} = test_ndd{i} / alpha(i);
	end
	
	train_cells_new = TransCellsToCellMat(train_ndd, inst_len_train, 1);
    test_cells_new = TransCellsToCellMat(test_ndd, inst_len_test, 1);
	%test_cells_new = TransCellsToCellMat(test_ndd', inst_len_test, 2)';
 end