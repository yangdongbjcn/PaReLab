function y = gray2ndDct(img, varargin)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    if ~exist('varargin', 'var') varargin = {}; end
    
    try
        compress_len = varargin{1};
    catch
        compress_len = 10;
    end
	
	img = mat2gray(img, [0, 255]);
	img = im2uint8(img);
	
	img_dct = dct2(img);
	
	img_dct_quant = dyangDctQuant(img_dct, 'qy'); % only for uint8 image
	
	y = dyangDctZigzag(img_dct_quant, 'zd');
	y = y(1:compress_len);
end