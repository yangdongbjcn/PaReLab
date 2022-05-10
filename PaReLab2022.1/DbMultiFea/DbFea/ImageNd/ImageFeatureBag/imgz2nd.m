function [data_nd, data_index] = imgz2nd(imgz, direction)
    % 
	% yangdongbjcn@hotmail.com
	% Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    if ~exist('direction','var')
		direction = 'col';
	end
	
    switch lower(direction)
        case 'col'
            for i = 1 : size(imgz,3)
                tmp1 = imgz(:,:,i);
                b(:,i) = tmp1(:);
            end
        case 'row'
            for i = 1 : size(imgz,3)
                tmp1 = imgz(:,:,i)';
                b(:,i) = tmp1(:);
            end
    end
    
    data_nd = b;
    
    data_index = produceIndex(size(imgz,1), size(imgz,2), direction);
end

function data_index = produceIndex(size1, size2, direction)
    switch lower(direction)
        case 'col'
            data_index = [];
            for i = 1 : size2
                tmp1 = [(1:size1)', ones(size1, 1)*i];
                data_index = [data_index; tmp1];
            end
        case 'row'
            data_index = [];
            for i = 1 : size1
                tmp1 = [ones(size2, 1)*i, (1:size1)'];
                data_index = [data_index; tmp1];
            end
    end
end