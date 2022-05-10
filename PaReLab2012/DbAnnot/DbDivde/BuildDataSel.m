function data_sel = BuildDataSel(data_num, exper_sel)
    data_sel = zeros(1, data_num);
    step = floor(data_num / length(exper_sel));
    for i = 1 : length(exper_sel) - 1
        if exper_sel(i) == 1
            indexStart = (i-1)*step + 1;
            indexEnd = i*step;
            data_sel(indexStart:indexEnd) = 1;
        end
    end
    i = length(exper_sel);
    if exper_sel(i) == 1
        indexStart = (i-1)*step + 1;
        data_sel(indexStart:end) = 1;
    end
end