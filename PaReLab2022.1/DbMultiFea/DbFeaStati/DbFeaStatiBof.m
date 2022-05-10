function result = DbFeaStatiBof(nd_cells, image_labels, cluster_num, sample_num)
	sample_nd_cells = RandSampling(nd_cells, sample_num);
    sample_nd_cells = reshape(sample_nd_cells, [length(sample_nd_cells), 1]);
    sample_nd = cell2mat(sample_nd_cells); 
    
    var_name = {'center_cd'};
    file_name = 'feastati_bof';
    file_path = [pwd, '/', file_name];
    try
        load(file_path, var_name{:});
    catch
        %[sample_label, center_cd] = KmeansDyang(sample_nd, cluster_num, 500);
        [sample_label, center_cd] = kmeans(sample_nd, cluster_num, 'emptyaction', 'singleton');
        
        save(file_path, var_name{:});
    end
        
    % data_label
    for i = 1 : length(nd_cells)
        data_nd = nd_cells{i};
        data2center = TransDataNdAndCenterCdToData2Center(data_nd, center_cd);
		
        data_label = TransData2CenterToDataLabel(data2center);
		hist_array(i, :) = hist(data_label, cluster_num);
        
%         u_cn = TransData2CenterToUCn(data2center);  
% 		hist_array(i, :) = max(u_cn, [], 2)';
    end
    data_nd = hist_array;
    len_arr = ones(1, length(nd_cells));
    new_cells = TransDataNdAndLengthsToCells(data_nd, len_arr);
    result{1} = new_cells;
    result{2} = center_cd;
end