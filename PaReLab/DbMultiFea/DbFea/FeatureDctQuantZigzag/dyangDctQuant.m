function b = dyangDctQuant(a, quant_cmd)
    % Quantize the dct coefficients.
	%
	% An example of quantizing a rgb image, 
	% b = dctQuant(a, 'qy');
	%
	% An example of recoverying a quantized image to a rgb image, 
	% b = dctQuant(a, 'ay');
	%
	% To quantize, use 'q', to anti-quantize (recovery), use 'a'.
	% 
	% If the image format is YCbCr, please use 'y' to quantize Y channel,
	% and use 'c' to quantize Cb and Cr channel. 
	% For other formats, please use 'y' for all channels.
	% 
	% yangdongbjcn@hotmail.com
	% Copyright (c) yangdong.bj.cn (2011). 
	% This software may be freely used and distributed for non-commercial purposes.
    %
	
    [s1 s2] = size(a);   
   
    % init
    quant_y = [16,11,10,16,24,40,51,61;
            12,12,14,19,26,58,60,55;
            14,13,16,24,40,57,69,56;
            14,17,22,29,51,87,80,62;
            18,22,37,56,68,109,103,77;
            24,35,55,64,81,104,113,92;
            49,64,78,87,103,121,120,101;
            72,92,95,98,112,100,103,99];
        
    quant_c = [17,18,24,47,99,99,99,99;
            18,21,26,66,99,99,99,99;
            24,26,56,99,99,99,99,99;
            47,66,99,99,99,99,99,99;
            99,99,99,99,99,99,99,99;
            99,99,99,99,99,99,99,99;
            99,99,99,99,99,99,99,99;
            99,99,99,99,99,99,99,99;];
        
    mask_y = zeros([s1 s2]) + 99;
    mask_y(1:size(quant_y,1), 1: size(quant_y,2)) = quant_y;
    mask_y = mask_y(1:s1, 1:s2);
    
    mask_c = zeros([s1 s2]) + 99;
    mask_c(1:size(quant_c,1), 1: size(quant_c,2)) = quant_c;
    mask_c = mask_c(1:s1, 1:s2);
    
        
    switch quant_cmd
        case 'qy'
            b = round(a ./ mask_y(1:s1,1:s2));
        case 'ay'
            b = round(a .* mask_y(1:s1,1:s2));
        case 'qc'
            b = round(a ./ mask_c(1:s1,1:s2));
        case 'ac'
            b = round(a .* mask_c(1:s1,1:s2));
    end
end
