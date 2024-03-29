function annot_labels = TransLabelsByDist(train_labels, imagesim_train_test, k, dist_mode)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    inst_label_num = 1;
    data_label_num = floor(mean(sum(train_labels, 2)));	% expected average test label number
    
    for i = 1 : size(imagesim_train_test, 2)
        %%
        t_dist = imagesim_train_test(:, i);
        [B, IX] = sort(t_dist, dist_mode);
        image_sel = IX;
        
        %%
        if length(image_sel) > k
            image_sel = image_sel(1 : k);
        end        
        
        labels_nk = TransBinLabelToNumLabel(GetInstanceLabels(image_sel, train_labels));
        %labels_nk = TransBinLabelToNumLabel(GetInstanceLabels(map_train, train_labels, inst_k));
        
        labels_k = VotingK(labels_nk, data_label_num);
        annot_label(i, 1 : length(labels_k)) = labels_k;
    end
    
    % if no one is selected
    label_num = size(train_labels, 2);
    annot_labels = TransNumLabelToBinLabel(annot_label, label_num);
end
