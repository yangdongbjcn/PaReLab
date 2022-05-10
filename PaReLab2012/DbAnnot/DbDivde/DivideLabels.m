function [train_labels, test_labels] = DivideLabels(image_labels, exper_sel)
    train_labels = zeros(size(image_labels));
	test_labels = zeros(size(image_labels));
	for i = 1 : size(image_labels, 2)
		t_labels = image_labels(:, i);
		data_num = length(find(t_labels));
		
		data_sel = BuildDataSel(data_num, exper_sel);
		
		train_labels(find(t_labels), i) = data_sel == 0;
		test_labels(find(t_labels), i) = data_sel ~= 0;
	end
end
