function [data_nd, zmatrix, data_index, block_num] = ...
	ImageNdScale(img, block_len, border_len, zoom_sizes, func_gray, para_gray)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
	if ~exist('para_gray', 'var')
		para_gray = {};
	end
    
	for i = 1 : length(zoom_sizes)
		tImg = imresize(img, zoom_sizes{i});
		[data_nd{i}, zmatrix{i}, data_index{i}, block_num{i}] = ...
			ImageNd(tImg, block_len, border_len, func_gray, para_gray);
	end
end