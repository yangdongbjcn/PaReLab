function zmatrix = ImageBlkprocTransToZmatrix(temp_mat, wh_size)
    %
    % code@dyang.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial
    % purposes.
    %	
    
    zmatrix = [];
	for i = 1 : size(temp_mat, 3)
        tmp = GrayBlkprocTransToZmatrix(temp_mat(:,:,i), wh_size);
        zmatrix = cat(3, zmatrix, tmp);
    end
end