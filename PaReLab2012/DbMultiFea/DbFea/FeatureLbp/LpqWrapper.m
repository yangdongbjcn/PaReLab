function y = LpqWrapper(x, varargin)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
	for i = 1 : size(x, 3)
        y(1, :, i) = lpq(x(:,:,i));
    end
end