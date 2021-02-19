function new_cells = TransDataNdAndLengthsToCells(data_nd, len_arr)
    i = 1;
    %t_dim = ndims(data_nd);
    t_dim = length(find(size(data_nd) ~= 1));
    for iLabel = 1 : length(len_arr)
        len = len_arr(iLabel);
        if  t_dim == 2
            new_cells{iLabel} = data_nd(i : i + len - 1, :);
        elseif  t_dim == 1
            new_cells{iLabel} = data_nd(i : i + len - 1);
        end
        i = i + len;
    end
end