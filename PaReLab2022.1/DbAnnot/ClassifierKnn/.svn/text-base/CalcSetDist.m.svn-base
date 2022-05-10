function dist = CalcSetDist(n1d, n2d, weights, dist_order)
    data_num = size(train_nd,1);
    test_mat = ones(data_num,1) * single(test_1d);
    
    switch dist_order
        case 0
            dist = DistMaxHausdorff(train_nd, test_mat);
        case 1
            dist = DistMinHausdorff(train_nd, test_mat, weights);
    end
end