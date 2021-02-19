function temp_mat = GrayBlkprocTransFromZmatrix(zmatrix, is_vetical)
    %
    % code@dyang.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial
    % purposes.
    %	
    
    if ~exist('is_vetical', 'var')
		is_vetical = true;
	end
    
    wh_size(1) = size(zmatrix, 1);
    wh_size(2) = size(zmatrix, 2);
    Z = size(zmatrix, 3);
    
	if is_vetical
		tmp1 = wh_size(1);
		tmp2 = (0 : tmp1 - 1)*Z;
		for i = 1 : Z
			temp_mat(tmp2 + i,:) = zmatrix(:,:,i);
		end
    else			
		tmp1 = wh_size(2);
		tmp2 = (0 : tmp1 - 1)*Z;
		for i = 1 : Z
			temp_mat(:, tmp2 + i) = zmatrix(:,:,i);
		end
    end
end

function blockNumberSize = blkprocBlockNumber(sizeOriginal, blkPara)
    size1 = blkPara.size1; size2 = blkPara.size2; 
    overlap1 = blkPara.overlap1; overlap2 = blkPara.overlap2; 
    num1 = ceil(sizeOriginal(1) / (size1 - overlap1)); 
    num2 = ceil(sizeOriginal(2) / (size2 - overlap2)); 
    blockNumberSize(1) = num1; blockNumberSize(2) = num2;
end

function isVertical = blkprocResultIsVertical(blockNumberSize, featureMatrixSize)
    if blockNumberSize(1) == featureMatrixSize(1)
        isVertical = false;
    else
        isVertical = true;
		assert(blockNumberSize(2) == featureMatrixSize(2));
    end
end