function [inst_k, inst_dist] = FindNearInstances(train_ndd, test_ndd, map_train, map_test, kii, weights, dist_order, dist_mode)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    fea_num = length(train_ndd);
    for i = 1 : fea_num
        dim_num(i) = size(train_ndd{1, i}, 2);
    end
    
%     [sample_ndd_train, sample_idx_all, map_sample] = randSamplingFromNdd(train_ndd, map_train, 5, 'norand');
%     thres = getThresFromSampledData(sample_ndd_train, test_ndd, map_test, weights, dist_order, dist_mode, kii);
    
    inst_num_test = size(test_ndd{1}, 1);
    for j = 1 : inst_num_test
        test_1d_cells = indexFromCells(test_ndd, j);
        t_dist = CalcMultiDist(train_ndd, test_1d_cells, weights, dist_order);
        % instsim_train_test(:, j) = - t_dist;
        [B, IX] = sort(t_dist, dist_mode);
        t_k = kii; % t_k = length(find(t_dist <= thres));
        B = B(1 : t_k);
        IX = IX(1 : t_k);
        
        inst_k(1 : length(IX), j) = reshape(IX, [length(IX), 1]); 
        inst_dist(1 : length(B), j) = reshape(B, [length(B), 1]); 
    end
end

function test_1d_cells = indexFromCells(test_ndd, j)
    test_1d_cells = cell(size(test_ndd));
    for i = 1 : length(test_ndd)
        test_1d_cells{i} = test_ndd{i}(j, :);
    end
end

%%
    
function [sample_ndd, sample_idx_all, map_sample] = randSamplingFromNdd(train_ndd, map_train, inst_num_sample, sel_mode)
    for j = 1 : length(train_ndd)
        sample_ndd{1, j} = [];
    end
    sample_idx_all = [];

    train_unique = unique(map_train);
    for i = 1 : length(train_unique)
        train_sel = find(map_train == train_unique(i));
        inst_num_train = length(train_sel);
        if inst_num_sample >= inst_num_train
            inst_num_sample = inst_num_train;
        end
        
        %%
        switch lower(sel_mode)
            case {'rand', 'random'}
                rand_idx = randperm(inst_num_train);
                rand_idx_top = rand_idx(1:inst_num_sample);
                sample_idx = train_sel(rand_idx_top);
            otherwise
                sample_idx = train_sel(1:inst_num_sample);
        end        
        
        %%
        sample_idx_all = [sample_idx_all, sample_idx];
        
        for j = 1 : length(train_ndd)
            t1 = train_ndd{1, j};
            sample_ndd{1, j} = [sample_ndd{1, j}; t1(sample_idx, :)];
        end
    end    
    
    train_num = length(train_unique);
    map_sample = BuildInstanceDataMap(ones(1, train_num) * inst_num_sample);
end

function thres = getThresFromSampledData(sample_ndd, test_ndd, map_test, weights, dist_order, dist_mode, thres_rate)
    inst_num_test = size(test_ndd{1}, 1);
    for j = 1 : inst_num_test
        test_1d_cells = indexFromCells(test_ndd, j);
        sample_dist(:, j) = CalcMultiDist(sample_ndd, test_1d_cells, weights, dist_order);
    end
%     [mask_ng, mask_upper, mask_lower] = FindNonDiag(size(sample_dist));
%     
%     if dist_mode == 'ascend'
%         sample_dist(~mask_ng) = realmax;
%     else
%         sample_dist(~mask_ng) = realmin;
%     end
    
    unique_test = unique(map_test);
    for i = 1 : length(unique_test)
        test_sel = map_test == unique_test(i);
        t_dist = sample_dist(:, test_sel);
        [B, IX] = sort(t_dist(:), dist_mode);
        t_thres1(i) = B(1);
    end
    
    thres2 = getThres(sample_dist(:), thres_rate, dist_mode);
    
    [B, IX] = sort([t_thres1, thres2], dist_mode);
    thres = B(end);
end

function thres = getThres(vec, num, dist_mode)
    [B,IX] = sort(vec, dist_mode);
    if num < 1
        k = floor(length(vec) * num);
    else
        k = num;
    end
    vec_top = vec(1 : k);
    thres = B(k);
end