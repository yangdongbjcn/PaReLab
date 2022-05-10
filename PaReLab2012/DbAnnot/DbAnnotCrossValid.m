function [result] = DbAnnotCrossValid(nd_cells, image_labels, exper_num, func_annot, para_annot, varargin)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    for i = 1 : exper_num
        exper_sel = BuildExperSel(exper_num, i);
        [train_labels, test_labels] = DivideLabels(image_labels, exper_sel);
        train_sel = sum(train_labels, 2) > 0;
        [train_data{i}, test_data{i}] = divideData(nd_cells, image_labels, train_sel);
        
        [classifier{i}, annot_labels{i}] = func_annot(train_data{i}, test_data{i}, para_annot{:});
        [precise{i}, recall{i}] = TranslateResult(annot_labels{i}, test_data{i}.label);
        
        mean_precise(i) = CaculateMeanResult(precise{i}, test_data{i}.label);
        mean_recall(i) = CaculateMeanResult(recall{i}, test_data{i}.label);
    end 
    
    mean_pr.precise = mean_precise;
    mean_pr.recall = mean_recall;
    result{1} = mean_pr;
    result{2} = train_data;
    result{3} = test_data;
    result{4} = classifier;
    result{5} = annot_labels;
    result{6} = precise;
    result{7} = recall;
end

function [train_data, test_data] = divideData(nd_cells, image_labels, train_sel)
    test_sel = ~train_sel;
    
    train_data.data = nd_cells(train_sel, :);
    test_data.data = nd_cells(test_sel, :);
    
    test_data.label = image_labels(find(test_sel), :);  
    train_data.label = image_labels;
    train_data.label(find(test_sel), :) = [];
end