function [func_annot, para_annot, annot_result, paths] = SetupCacheDbAnnot(paths, exper_num, testidx, nd_cells, image_labels, class_name, para_class)	
	% result_sel = DbFeaRemoveEmpty(nd_cells, image_labels);
    % empty_sel = result_sel{1};
    % nd_cells = result_sel{2};
    % image_labels = result_sel{3};
    
    func_class = setupClassifier(class_name);
    
    if exper_num == 1
        annot_name = 'OnceValidation';
        test_cells = nd_cells(testidx, :);
        train_cells = nd_cells;
        train_cells(testidx, :) = [];

        test_labels = image_labels(testidx, :);
        train_labels = image_labels;
        train_labels(testidx, :) = [];

        func_annot = @DbAnnot;
        para_annot = {train_cells, train_labels, test_cells, test_labels, func_class, para_class};
    else
        annot_name = 'CrossValidation';
        func_annot = @DbAnnotCrossValid;
        para_annot = {nd_cells, image_labels, exper_num, func_class, para_class};
    end
    
    paths.annot_path = [paths.fea_path, annot_name, '/'];
    mkdir(paths.annot_path); cd(paths.annot_path);
    
% 	annot_result = DbCache(func_annot, para_annot, paths.annot_path, [], 'single');
    annot_result = func_annot(para_annot{:});
end

function func_class = setupClassifier(class_name)
    switch lower(class_name)
        case {'knn'}
            func_class = @ClassifierKnn;
        case {'bayes'}
            func_class = @ClassifierBayes;
        case {'vs', 'visualsynset', 'visual synset'}
            func_class = @ClassifierVisualSynset;
    end
end