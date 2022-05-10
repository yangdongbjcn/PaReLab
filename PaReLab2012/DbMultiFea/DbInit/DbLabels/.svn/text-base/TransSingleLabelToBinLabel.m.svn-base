function data_labels = TransSingleLabelToBinLabel(data_label, label_num)
    unique_ids = unique(data_label);
    id_num = length(unique_ids);

    if exist('label_num', 'var')
	if label_num < id_num
	    label_num = id_num;
	end	
    else
	label_num = id_num;
    end

    data_labels = zeros(length(data_label), label_num);
    for i = 1 : id_num
        t_idx = data_label == unique_ids(i);
        data_labels(t_idx, i) = 1;
    end
end