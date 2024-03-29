function Demo()
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011).
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    top_path = AddPath();
    
    % multiple instance feature parameters
    block_len = 32;
    border_len = 0;
    multi_scale = {[64, 96], [32, 48]};
    multi_scale = {[32, 48]};
    basis_num = 256;
    sample_num = 1000;
	
    % knn classifier parameters
    for data_label_num = 1 : 10
        
    	k = 5;
        dim_sel = 0;
        dist_order = 1;
        mil_way = 2;

        fea_names = {'lbp32'};

        [paths, label_names, image_names, image_labels, nd_cells] = ...
            DbMultiFea(top_path, 'Data', 'BnuCampus5s320x240', 'jpg', ...
            fea_names([1]), block_len, border_len, multi_scale, {basis_num, sample_num});

        [func_annot, para_annot, annot_result, paths] = SetupCacheDbAnnot(paths, 3, [], nd_cells, image_labels, 'knn', {k, dim_sel, dist_order, mil_way, data_label_num});

        precise_knn = annot_result{1}.precise;
        recall_knn = annot_result{1}.recall;
        
        precise(data_label_num) = mean(precise_knn);
        recall(data_label_num) = mean(recall_knn);
    end
    save('roc', 'precise', 'recall');
end

