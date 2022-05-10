function inst_id = BuildInstanceDataMap(inst_len)
    inst_id = [];
    for i = 1 : length(inst_len)
        tmp = ones(1, inst_len(i)) * i;
        inst_id = [inst_id, tmp];
    end
end