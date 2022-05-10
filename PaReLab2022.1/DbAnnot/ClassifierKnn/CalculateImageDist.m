function imagesim_train_test = CalculateImageDist(train_cells, test_cells)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    for i = 1 : length(train_cells)
        for j = 1 : length(test_cells)
            imagesim_train_test(i, j) = DistMaxHausdorff(train_cells{i}, test_cells{j});
        end
    end
end
