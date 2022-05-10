function  block_num = ImageBlkprocSize(gray_size, block_size, border_size)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
    block_num(1) = ceil(gray_size(1) / (block_size(1) - 2*border_size(1))); 
    block_num(2) = ceil(gray_size(2) / (block_size(2) - 2*border_size(2)));
end