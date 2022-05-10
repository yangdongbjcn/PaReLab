function [classifier, annot_labels] = ClassifierBayes(train_data, test_data, data_label_num)
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
    
    var_name1 = 'result';
    file_path = [fileparts(pwd), '/', var_name1];
    load(file_path, var_name1);
    UBM = result{2};
	gmm_cells = result{3};
    
    var_name2 = 'label_gmms';
    file_path = [pwd, '/', var_name2];
    try
		load(file_path, var_name2);
    catch
        for i = 1 : size(train_labels, 2)
            t_sel = train_labels(:, i) == 1;
            data_nd = TransHierCellsToDataNd(train_cells(t_sel, :));
            label_gmms{i} = ubm2gmm(ubm, data_nd, cfg_ubm);
        end
        save(file_path, var_name2);
    end
    
%     dist_mode = 'ascend';
%     switch mil_way
%         case 1
%             imagesim_train_test = CalculateImageDist(train_cells, test_cells);
%             annot_labels = TransLabelsByDist(train_labels, imagesim_train_test, k, dist_mode);
%         case 2
%             [imagesim_train_test, imagenn_train_test] = FindNearImages(train_cells, test_cells, train_labels, k, dim_sel, dist_order, dist_mode);
%             annot_labels = TransLabels(train_labels, imagesim_train_test, imagenn_train_test, k, dist_mode, data_label_num);
%     end
end