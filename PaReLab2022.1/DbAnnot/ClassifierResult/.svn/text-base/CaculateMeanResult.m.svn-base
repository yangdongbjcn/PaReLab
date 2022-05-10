function mean_precise = CaculateMeanResult(precise, test_labels)
	label_num = size(test_labels, 2);
	real_num = sum(test_labels, 1);
	real_num = length(find(real_num));
	mean_precise = mean(precise) * label_num / real_num;
end


