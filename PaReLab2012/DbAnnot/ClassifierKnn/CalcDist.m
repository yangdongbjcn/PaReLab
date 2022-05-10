function dist = CalcDist(train_nd, test_1d, weights, dist_order)
    data_num = size(train_nd,1);
    test_mat = ones(data_num,1) * single(test_1d);
    
    switch dist_order
        case 0
            dist = DistL0(train_nd, test_mat);
        case 1
            dist = DistL1(train_nd, test_mat, weights);
        case 2
            dist = DistL2(train_nd, test_mat, weights);
		case 3
            dist = DistKl(train_nd, test_mat, weights);
		case 4
			dist = DistChiSquare(train_nd, test_mat, weights);
        case 5
            dist = DistMaxHausdorff(train_nd, test_mat);
    end
end