function y = ColorHist(x, color_space, bins, varargin)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	if ~exist('color_space', 'var')
		color_space = 'rgb';
	end
	
	if ~exist('bins', 'var')
		bins = 16;
	end
	
	switch lower(color_space)
		case 'rgb'
			x = x;
		case 'hsv'
			x = rgb2hsv(x);
	end
	
	for i = 1 : size(x, 3)
        x1 = single(x(:,:,i));
        y(1, :, i) = hist(x1(:), bins);
    end
end