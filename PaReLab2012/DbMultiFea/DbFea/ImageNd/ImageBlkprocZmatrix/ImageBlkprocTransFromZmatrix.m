function temp_mat = ImageBlkprocTransFromZmatrix(zmatrix, is_vetical)
    %
    % code@dyang.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial
    % purposes.
    %	
    
    if ~exist('is_vetical', 'var')
		is_vetical = true;
	end
    
    img_z = size(zmatrix, 3);
	gray_z = img_z / 3;
	
	for i = 1 : 3
		index = (i-1) * gray_z + 1 : i * gray_z;
		temp_mat(:, :, i) = GrayBlkprocTransFromZmatrix(zmatrix(:, :, index), is_vetical);
	end
end