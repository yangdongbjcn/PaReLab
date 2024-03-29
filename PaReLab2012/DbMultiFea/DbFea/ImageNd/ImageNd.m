function [data_nd, zmatrix, data_index, block_num] = ImageNd(img, block_len, border_len, func_gray, para_gray)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
	if ~exist('para_gray', 'var')
		para_gray = {};
	end
    		
    block_num = ImageBlkprocSize([size(img, 1), size(img,2)], [block_len block_len], [border_len border_len]);  
	
% 	for i = 1 : size(img, 3)
% 		temp_mat(:,:,i) = blkproc(img(:,:,i), [block_len-2*border_len block_len-2*border_len], [border_len border_len], func_gray, para_gray{:});
% 	end

    temp_mat = ImageBlkproc(img, [block_len-2*border_len block_len-2*border_len], [border_len border_len], func_gray, para_gray{:});
	
    zmatrix = ImageBlkprocTransToZmatrix(temp_mat, block_num);
    			
    [data_nd, data_index] = imgz2nd(zmatrix);
end