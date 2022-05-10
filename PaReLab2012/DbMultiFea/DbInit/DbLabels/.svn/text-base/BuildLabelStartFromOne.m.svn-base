function data_label_new = BuildLabelStartFromOne(data_label)
    unique_ids = unique(data_label);
    id_num = length(unique_ids);
    data_label_new = zeros(size(data_label));
    for i = 1 : id_num
        t_idx = data_label == unique_ids(i);
        data_label_new(t_idx) = i;
    end
end