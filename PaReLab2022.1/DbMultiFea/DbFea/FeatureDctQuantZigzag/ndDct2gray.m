function img = ndDct2gray(x, varargin)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    if ~exist('varargin', 'var') cfg = {}; end
    try
        block_len = varargin{1};
    catch
        block_len = 8;
    end
	
    img_dct = dyangDctZigzag(x, 'ad', [block_len block_len]);
	img_dct = dyangDctQuant(img_dct, 'ay');
	img = idct2(img_dct);
	img = uint8(img);
end