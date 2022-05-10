function [result] = DbAnnot(datand_cells_tr, image_labels_tr, datand_cells_ts, image_labels_ts, func_annot, para_annot, varargin)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    train_data.data = datand_cells_tr;
    train_data.label = image_labels_tr;
    
    test_data.data = datand_cells_ts;
    test_data.label = image_labels_ts;
        
    [classifier, annot_labels] = func_annot(train_data, test_data, para_annot{:});
    [precise, recall] = TranslateResult(annot_labels, test_data.label);
    
    mean_pr.precise = CaculateMeanResult(precise, test_data.label);
    mean_pr.recall = CaculateMeanResult(recall, test_data.label);
    result{1} = mean_pr;
    result{2} = train_data;
    result{3} = test_data;
    result{4} = classifier;
    result{5} = annot_labels;
    result{6} = precise;
    result{7} = recall;
end
