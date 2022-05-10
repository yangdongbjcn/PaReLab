function [sorted_data_label, sorted_cluster_label] = SortDataLabel(data_label)	
    % Sorted by point number of each cluster
    %
	% yangdongbjcn@hotmail.com
	% Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    data_label = reshape(data_label, length(data_label), 1);
    sorted_data_label = zeros(size(data_label));

    % [cluster_size, cluster_label] = findClusterSizeByUsualMethod(data_label);
    [cluster_size, cluster_label] = findClusterSizeByStrangeMethod(data_label);

    [sorted_cluster_size, IX] = sort(cluster_size, 'descend');
    sorted_cluster_label = cluster_label(IX);
        
    % according to index_order, replace map
    for i = 1 : length(sorted_cluster_label)
        sorted_data_label(data_label == sorted_cluster_label(i) ) = i;
    end
end

function [cluster_size, cluster_label] = findClusterSizeByUsualMethod(data_label)
    cluster_label = unique(data_label);
    cluster_num = length(cluster_label);
    for t_i = 1 : cluster_num
       cluster_size(t_i) = length(find(data_label == cluster_label(t_i)));        
    end
end

function [cluster_size, cluster_label] = findClusterSizeByStrangeMethod(data_label)
    sorted_array = sort(data_label);
	t_1 = diff([sorted_array(1) - 10; sorted_array; sorted_array(end) + 10]);
    first_datum_pos = find(t_1);
    cluster_size = diff(first_datum_pos);
    
    cluster_label = unique(data_label);
end