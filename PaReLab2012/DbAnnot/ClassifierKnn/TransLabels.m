function annot_labels = TransLabels(train_labels, imagesim_train_test, imagenn_train_test, k, dist_mode, data_label_num, trans_mode)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    if ~exist('trans_mode')
        trans_mode = 'first_rest';
    end
    
    inst_label_num = 1;
    
    for i = 1 : size(imagesim_train_test, 2)
        %%
%         t_dist = imagesim_train_test(:, i);
%         mask_nnan = ~isnan(t_dist);
%         order_nnan = find(mask_nnan);
%         
%         [B, IX] = sort(t_dist(mask_nnan), dist_mode);
%         image_sel = order_nnan(IX);
        
        %%
        t_nn = imagenn_train_test(:, i);
        mask_nnan = ~isnan(t_nn);
        order_nnan = find(mask_nnan);
        
        if all(t_nn(mask_nnan) == 1)
            t_dist = imagesim_train_test(:, i);
            [B, IX] = sort(t_dist(mask_nnan), dist_mode);
            image_sel = order_nnan(IX);
        else
            [B, IX] = sort(t_nn(mask_nnan), 'descend');
            image_sel = order_nnan(IX);
        end

        %%
        if length(image_sel) > k
            image_sel = image_sel(1 : k);
        end        
        
        %labels_nk = TransBinLabelToNumLabel(GetInstanceLabels(map_train, train_labels, inst_k));
        
        switch trans_mode
            case 'first_rest'                
%         labels_nk = TransBinLabelToNumLabel(GetInstanceLabels(image_sel, train_labels));
%         labels_k = VotingK(labels_nk, data_label_num);
                labels_k = VotingKSoftLabelsFirstRest(GetInstanceLabels(image_sel, train_labels), data_label_num);
            case 'all'
                labels_k = VotingKSoftLabels(GetInstanceLabels(image_sel, train_labels), data_label_num);
        end
        
        annot_label(i, 1 : length(labels_k)) = labels_k;
    end
    
    % if no one is selected
    label_num = size(train_labels, 2);
    annot_labels = TransNumLabelToBinLabel(annot_label, label_num);
end
