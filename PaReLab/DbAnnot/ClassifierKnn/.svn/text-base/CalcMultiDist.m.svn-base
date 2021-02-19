function dist = CalcMultiDist(train_ndd, test_1d_cells, weights, dist_order) 
    
    fea_num = length(test_1d_cells);
    for i = 1 : fea_num
        dim_num(i) = size(test_1d_cells{1, i}, 2);
    end
    dim_map = BuildInstanceDataMap(dim_num);
    
    dist = 0;
    for i = 1 : length(train_ndd)
        dim_sel = dim_map == i;
        weights_sel = weights(dim_sel);
        dist = dist + CalcDist(train_ndd{i}, test_1d_cells{i}, weights_sel, dist_order);
    end
end