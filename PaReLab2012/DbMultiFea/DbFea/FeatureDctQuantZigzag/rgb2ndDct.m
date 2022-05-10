function y = rgb2ndDct(img, varargin)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
	for i = 1 : size(img, 3)
		y(1, :, i) = gray2ndDct(img(:, : , i), varargin{:});
	end
end