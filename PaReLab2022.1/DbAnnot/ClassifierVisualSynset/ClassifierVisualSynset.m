function [classifier, annot_labels] = ClassifierVisualSynset(train_data, test_data, k, dim_sel, dist_order, mil_way, pf, svm_thres, data_label_num)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    classifier = [];
    
    train_cells = train_data.data;
    train_labels = train_data.label;
    test_cells = test_data.data;
    
    if ~exist('data_label_num', 'var')
        data_label_num = floor(mean(sum(train_labels, 2)));	% expected average test label number
    end
    
    [train_cells, test_cells] = NormDataByMaxMinSum(train_cells, test_cells);
    
    var_name2 = {'train_nnd', 'data_vs', 'center_i', 'cm'};
    file_name2 = 'visual_synsets';
    file_path = [pwd, '/', file_name2, num2str(pf)];
    try
		load(file_path, var_name2{:});
    catch
        [train_nnd, inst_len_train] = TransCellMatToCells(train_cells, 2);
        [data_nd] = TransCellsToDataNd(train_nnd, 1);
        tmp = pdist(data_nd);
        S = squareform(tmp);
        S = - S.^2;
        S = S + diag(mean(S)) * pf;
        [data_vs, center_i, cm] = apclusterWrapper(S);
        save(file_path, var_name2{:});
    end
    
    unique_vs = unique(data_vs);
    vs_num = length(unique_vs);
    for i = 1 : vs_num
        t_sel = find(data_vs == unique_vs(i));
        %vs_cells = train_nnd(t_sel);
        sel_cells = train_cells(t_sel, :);
        for j = 1 : size(sel_cells, 2)
            tmp = cell2mat(sel_cells(:, j));
            vs_cells{i, j} = mean(tmp, 1);
        end
        sel_labels = train_labels(t_sel, :);
        mean_labels(i, :) = mean(sel_labels, 1);
        vs_tf(i, :) = mean_labels(i, :) / sum(mean_labels(i, :));
        sum_labels = sum(sel_labels, 1);
        vs_idf(i, :) = log(vs_num ./ (1 + sum_labels));
        vs_labels(i, :) = vs_tf(i, :) .* vs_idf(i, :);
    end
    
%     knn_data.data = [train_cells];
%     knn_data.label = train_labels;
%     trans_mode = 'first_rest';
%     [tmp, annot_labels] = ClassifierKnn(knn_data, test_data, k, dim_sel, dist_order, mil_way, data_label_num, trans_mode);
    
    
    knn_data.data = [vs_cells];
%     knn_data.label = vs_labels;
%     knn_data.label = [mean_labels];
    knn_data.label = diag(ones(1,vs_num));
    trans_mode = 'all';
    [tmp, annot_labels] = ClassifierKnn(knn_data, test_data, 2*k, dim_sel, dist_order, mil_way, data_label_num, trans_mode);
    
    for i = 1 : length(test_cells)
        annot_vs = annot_labels(i, :);
        vs_sel = find(annot_vs);
        knn_data.data = [];
        knn_data.label = [];
        for j = 1 : length(vs_sel)
            t_sel = data_vs == vs_sel(j);
            knn_data.data = [knn_data.data; train_cells(t_sel, :)];
            knn_data.label = [knn_data.label; train_labels(t_sel, :)];
        end
        knn_test_data.data = test_data.data(i, :);
        knn_test_data.label = test_data.label(i, :);
        trans_mode = 'first_rest';
        [tmp, t_annot] = ClassifierKnn(knn_data, test_data, k, dim_sel, dist_order, mil_way, data_label_num, trans_mode);
        new_annot_labels(i, :) = t_annot(i, :);
    end
    annot_labels = new_annot_labels;
    
%     knn_data.data = vs_cells;
%     knn_data.label = diag(ones(1,vs_num));
%     [tmp, annot_vs, Y] = ClassifierLsvm(knn_data, test_data);
%     
%     mean_y = mean(Y(:));
%     min_y = min(Y(:));
%     max_y = max(Y(:));
%     
%     if ~exist('svm_thres', 'var')
%         svm_thres = 0.5;
%     end
%     
%     thres_y = min_y + (max_y - min_y) * svm_thres;
%     
%     annot_vs = Y > thres_y;
%     
%     annot_labels_soft = annot_vs * vs_labels;
%     
%     label_num = size(train_labels, 2);
%     for i = 1 : size(annot_labels_soft, 1)
%         [C, IX] = sort(annot_labels_soft(i, :), 'descend');
%         tmp = IX(1 : data_label_num);
%         annot_labels(i, :) = TransNumLabelToBinLabel(tmp, label_num);
%     end
end