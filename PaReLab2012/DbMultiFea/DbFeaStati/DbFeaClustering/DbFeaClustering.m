function result = DbFeaClustering(nd_cells, image_labels, cluster_num, varargin)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
	for i = 1 : size(image_labels, 2)
		image_sel = find(image_labels(:, i));
		
		[data_nd, len_arr] = TransCellsToDataNd( nd_cells(image_sel) );
		
		%[cluster_cells, data_label, center_cd] = KmeansCells(data_nd, cluster_num);
		[data_label, center_cd] = kmeans(data_nd, cluster_num, 'emptyaction', 'singleton');
        u_nc = TransNumLabelToBinLabel(data_label, cluster_num);
        u_cn = u_nc';
		
		result{i}{1} = center_cd;
        result{i}{2} = u_cn;
	end
end