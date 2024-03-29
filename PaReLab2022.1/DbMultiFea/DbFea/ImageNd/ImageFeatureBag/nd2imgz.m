function imgz = nd2imgz(data_nd, col_len, row_len, direction)
    % 
	% yangdongbjcn@hotmail.com
	% Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
	if ~exist('direction','var')
		direction = 'col';
	end
    
    n = size(data_nd,1);
    d = size(data_nd,2);
    assert(n == col_len * row_len);
    
    % switch
    switch lower(direction)
        case 'col'
            for i = 1 : d
                tmp1 = data_nd(:,i);
                b(:,:,i) = reshape(tmp1, [col_len row_len]);
            end
        case 'row'
            for i = 1 : d
                tmp1 = data_nd(:,i);
                tmp2 = reshape(tmp1, [row_len col_len]);
                b(:,:,i) = tmp2';
            end
    end
    
    imgz = b;
end