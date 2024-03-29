function img = NdImage(data_nd, block_len, block_num, func_gray, para_gray)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
        
    if ~exist('para_gray', 'var') 
		para_gray = {}; 
	end
        
    zmatrix = nd2imgz(data_nd, block_num(1), block_num(2));
        
    compress_len = size(zmatrix, 3) / 3;
    
    temp_mat = ImageBlkprocTransFromZmatrix(zmatrix);
    for i = 1 : size(temp_mat, 3)
		img(:,:,i) = blkproc(temp_mat(:,:,i), [compress_len 1], @fTemp, func_gray, para_gray);
	end
end

function y = fTemp(x, func_gray, para_gray)
	y = func_gray(x, para_gray{:});
end