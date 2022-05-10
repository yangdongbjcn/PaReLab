function zmatrix = GrayBlkprocTransToZmatrix(temp_mat, wh_size)
    %
    % code@dyang.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial
    % purposes.
    %	
    
	if blkprocResultIsVertical(wh_size, size(temp_mat))
		Z = size(temp_mat, 1) / wh_size(1);		
		tmp1 = wh_size(1);
		tmp2 = (0 : tmp1 - 1)*Z;
		for i = 1 : Z
			w_h_z(:,:,i) = temp_mat(tmp2 + i,:);
		end
	else
		Z = size(temp_mat, 2) / wh_size(2);				
		tmp1 = wh_size(2);
		tmp2 = (0 : tmp1 - 1)*Z;
		for i = 1 : Z
			w_h_z(:,:,i) = temp_mat(:, tmp2 + i);
		end
	end
	zmatrix = w_h_z;
end

function isVertical = blkprocResultIsVertical(blockNumberSize, featureMatrixSize)
    if blockNumberSize(1) == featureMatrixSize(1)
        isVertical = false;
    else
        isVertical = true;
		assert(blockNumberSize(2) == featureMatrixSize(2));
    end
end