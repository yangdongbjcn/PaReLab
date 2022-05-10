function [classifier, annot_labels, Y] = ClassifierLsvm(train_data, test_data, data_label_num)

	classifier = [];
    
    train_cells = train_data.data;
    train_labels = train_data.label;
	% should be single-label
	tmp = sum(train_labels, 1);
	assert(all(tmp == 1));
	
    test_cells = test_data.data;
% 	test_labels = test_data.label;
% 	% should be single-label
% 	tmp = sum(test_labels, 1);
% 	assert(all(tmp == 1));
	
	if ~exist('data_label_num', 'var')
        data_label_num = floor(mean(sum(train_labels, 2)));	% expected average test label number
    end
    
	[train_cells, test_cells] = NormDataByMaxMinSum(train_cells, test_cells);
	
	[train_nnd, inst_len_train] = TransCellMatToCells(train_cells, 2);
    [tr_nd] = TransCellsToDataNd(train_nnd, 1);
	[test_nnd, inst_len_train] = TransCellMatToCells(test_cells, 2);
    [ts_nd] = TransCellsToDataNd(test_nnd, 1);
	
	label_num = size(train_labels, 2);
	unique_labels = 1 : label_num;
	tr_label = TransBinLabelToNumLabel(train_labels);
% 	ts_label = TransBinLabelToNumLabel(test_labels);
	[C, Y] = scSpmLsvmWrapper(tr_nd, ts_nd, label_num, unique_labels, tr_label); 
        
    annot_labels = TransNumLabelToBinLabel(C, label_num);
end

function [C, Y] = scSpmLsvmWrapper(tr_nd, ts_nd, label_num, unique_labels, tr_label, ts_label)
%% evaluate the performance of the computed feature using linear SVM

	% [dimFea, numFea] = size(sc_fea);
	% unique_labels = unique(sc_label);
	% label_num = length(unique_labels);

% 	nRounds = 5;                        % number of random tests
	lambda = 0.1;                       % regularization parameter for w
	
% 	accuracy = zeros(nRounds, 1);
	
% 	for ii = 1:nRounds,
% 		fprintf('Round: %d...\n', ii);
		% tr_idx = [];
		% ts_idx = [];
		
		% for jj = 1:label_num,
			% idx_label = find(sc_label == unique_labels(jj));
			% num = length(idx_label);
			
			% idx_rand = randperm(num);
			
			% tr_idx = [tr_idx; idx_label(idx_rand(1:tr_num))];
			% ts_idx = [ts_idx; idx_label(idx_rand(tr_num+1:end))];
		% end;
		
		% tr_fea = sc_fea(:, tr_idx);
		% tr_label = sc_label(tr_idx);
		
		% ts_fea = sc_fea(:, ts_idx);
		% ts_label = sc_label(ts_idx);
		
		% [w, b, class_name] = li2nsvm_multiclass_lbfgs(tr_fea', tr_label, lambda);
		[w, b, class_name] = li2nsvm_multiclass_lbfgs(tr_nd, tr_label, lambda);

		% [C, Y] = li2nsvm_multiclass_fwd(ts_fea', w, b, class_name);
		[C, Y] = li2nsvm_multiclass_fwd(ts_nd, w, b, class_name);

% 		acc = zeros(length(class_name), 1);
% 		
% 		for jj = 1 : length(class_name),
% 			c = class_name(jj);
% 			idx = find(ts_label == c);
% 			curr_pred_label = C(idx);
% 			curr_gnd_label = ts_label(idx);    
% 			acc(jj) = length(find(curr_pred_label == curr_gnd_label))/length(idx);
% 		end; 
% 		
% 		accuracy(ii) = mean(acc); 
% 	end;

end