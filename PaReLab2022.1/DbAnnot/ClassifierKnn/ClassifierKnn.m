function [classifier, annot_labels] = ClassifierKnn(train_data, test_data, k, dim_sel, dist_order, mil_way, data_label_num, trans_mode)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    if ~exist('k', 'var')
        k = 50;
    end    
    
    if ~exist('dim_sel', 'var')
        dim_sel = 0;
    end
    
    if ~exist('dist_order', 'var')
        dist_order = 1;
    end
    
    if ~exist('mil_way', 'var')
        mil_way = 1;
    end
    
    classifier = [];
    
    train_cells = train_data.data;
    train_labels = train_data.label;
    test_cells = test_data.data;
    
    if ~exist('data_label_num', 'var')
        data_label_num = floor(mean(sum(train_labels, 2)));	% expected average test label number
    end
    
    if ~exist('trans_mode')
        trans_mode = 'first_rest';
    end
    
%     [train_cells, test_cells] = NormDataByMaxMinSum(train_cells, test_cells);
    
    dist_mode = 'ascend';
    switch mil_way
        case 1
            imagesim_train_test = CalculateImageDist(train_cells, test_cells);
            annot_labels = TransLabelsByDist(train_labels, imagesim_train_test, k, dist_mode);
        case 2
            [imagesim_train_test, imagenn_train_test] = FindNearImages(train_cells, test_cells, train_labels, k, dim_sel, dist_order, dist_mode);
            annot_labels = TransLabels(train_labels, imagesim_train_test, imagenn_train_test, k, dist_mode, data_label_num, trans_mode);
    end
end