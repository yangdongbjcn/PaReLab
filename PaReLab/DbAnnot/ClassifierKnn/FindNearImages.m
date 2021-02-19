function [imagesim_train_test, imagenn_train_test] = FindNearImages(train_cells, test_cells, train_labels, k, dim_sel, dist_order, dist_mode)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
        
    % feature selection
    weights = SelFea(train_cells, train_labels, dim_sel);
    
    % instance based
    [train_ndd, inst_len_train] = TransCellMatToCells(train_cells, 1);
    map_train = BuildInstanceDataMap(inst_len_train);
    [test_ndd, inst_len_test] = TransCellMatToCells(test_cells, 1);
    map_test = BuildInstanceDataMap(inst_len_test);
    
    mean_inst_num = computeMeanInstNum(train_cells);
    kii = floor(mean_inst_num) * k;
            
    [inst_k, inst_dist] = FindNearInstances(train_ndd, test_ndd, map_train, map_test, kii, weights, dist_order, dist_mode);
    
    % kii is the threshold k for instance.
    [imagesim_train_test, imagenn_train_test] = mapSparseInstToImageSimMat(inst_k, inst_dist, map_train, map_test, dist_mode);
end

function mean_inst_num = computeMeanInstNum(nd_cells)
    nd_cells = nd_cells(:);
    for i = 1 : length(nd_cells)
        x(i) = size(nd_cells{i}, 1);
    end
    mean_inst_num = mean(x);
end

function [imagesim_train_test, imagenn_train_test] = mapSparseInstToImageSimMat(inst_k, inst_dist, map_train, map_test, dist_mode)
    imagesim_train_test = zeros(length(unique(map_train)), length(unique(map_test))) * NaN;
    imagenn_train_test = zeros(size(imagesim_train_test)) * NaN;

    unique_test = unique(map_test);
    for i = 1 : length(unique_test)
        test_sel = map_test == unique_test(i);
        
        inst_tk = inst_k(:, test_sel);
        nz_sel = find(inst_tk);
        image_idx = TransInstanceToData(inst_tk(nz_sel), map_train);
        
       %%
        inst_tdist = inst_dist(:, test_sel);
        [t_dist, t_k] = meanColumnByGroup(inst_tdist(nz_sel), image_idx);   % sum is wrong!
        
%         [B, IX] = sort(t_dist, dist_mode);
%         t_dist = B; t_k = t_k(IX);        
%         image_dist(1 : length(t_dist), i) = reshape(t_dist, [length(t_dist), 1]);
%         image_k(1 : length(t_k), i) = reshape(t_k, [length(t_k), 1]);
        
        imagesim_train_test(t_k, i) = t_dist;
       
       %%
       if length(unique(image_idx)) == 1
            imagenn_train_test(image_idx, i) = 1;
       else
            t_k = unique(image_idx);
            t_nn = hist(image_idx, t_k);
            imagenn_train_test(t_k, i) = t_nn;
       end
    end
end
    
function [new_vec, unique_group] = meanColumnByGroup(vec, group)
    unique_group = unique(group);
    for i = 1 : length(unique_group)
        sel = group == unique_group(i);
        new_vec(i) = mean(vec(sel));
    end
end