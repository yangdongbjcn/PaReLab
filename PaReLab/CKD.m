function CKD()
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011).
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    top_path = AddPath();
	
    block_len = 32;
    border_len = 16;
    multi_scale = {[128, 192], [64, 96], [32, 48]};
    basis_num = 256;
    sample_num = 20000;
    
	k = 5;
    dim_sel = 0;
    dist_order = 1;
    mil_way = 2;
    data_label_num = 5;
	
%     fea_names = {'rgbhistogram'...
% %                 ,'opponenthistogram'... 
% %                 ,'huehistogram'...
% %                 ,'nrghistogram'...
% %                 ,'transformedcolorhistogram'...
% %                 ,'colormoments'...
% %                 ,'colormomentinvariants'...
% %                 ,'sift'...
% %                 ,'huesift'...
% %                 ,'hsvsift'...
% %                 ,'opponentsift'...
% %                 ,'rgsift'...
% %                 ,'csift'...
% %                 ,'rgbsift'...
%                 };

     fea10_names = {'fea10_hsv16'...
                ,'fea10_hsv16saliency'...
                ,'fea10_lab16'...
                ,'fea10_lab16saliency'...
                ,'fea10_opp64'...
                ,'fea10_opp64sal'...
                ,'fea10_rg64'...
                ,'fea10_rg64sal'...
                ,'fea10_rgb16'...
                ,'fea10_rgb16saliency'};
            
    %sel = nchoosek(1:10, 6);
    sel = [2, 6, 7; 6, 7, 8];
    
    for i = 1 : size(sel, 1)
        fea_n_names_cell{i} = fea10_names(sel(i, :));
    end
            
    %fea_names = {'sift_ds->scubmbof'};
    for i = 1 : length(fea_n_names_cell)
        fea_names_cell{i} = {'sift_ds->scubmbof', fea_n_names_cell{i}{:}};
    end
    
    fea_names_cell = {};
%     fea_names_cell{1} = {'sift_ds->scmuubmbof', 'colors14_ds_csift->scubmbof'};
    fea_names_cell{1} = {'sift_ds->scmuubmbof'};
%     fea_names_cell{1} = {'sift_ds->scubmbof', 'colors14_ds_csift->scubmbof'};

%     fea_names = {'rgb16','opp64sal'};
    
    pf = 1;
    
    for j = 1 : 1
    svm_thres = 0.1 * j;
        
    for i = 1 : length(fea_names_cell)
        fea_names = fea_names_cell{i};
		[paths, label_names, image_names, image_labels, nd_cells] = ...
			DbMultiFea(top_path, 'Data', 'Corel500', 'jpg', ...
			fea_names, block_len, border_len, multi_scale, {basis_num, sample_num});
        
		load([paths.dataset_path, '/', 'testidx'], 'testidx');
%         [func_annot, para_annot, annot_result, paths] = SetupCacheDbAnnot(paths, 1, testidx, nd_cells, image_labels, 'knn', {k, dim_sel, dist_order, mil_way, data_label_num});
        [func_annot, para_annot, annot_result, paths] = SetupCacheDbAnnot(paths, 1, testidx, nd_cells, image_labels, 'vs', {k, dim_sel, dist_order, mil_way, pf, svm_thres, data_label_num});
        %         [func_annot, para_annot, annot_result, paths] = SetupCacheDbAnnot(paths, 1, testidx, nd_cells, image_labels, 'bayes', {});
        
        precise(i) = annot_result{1}.precise;
        recall(i) = annot_result{1}.recall;
    end
    
        p(j) = precise;
        r(j) = recall;
    end
end

