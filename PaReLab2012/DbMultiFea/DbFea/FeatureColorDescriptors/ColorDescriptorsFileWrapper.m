function [data_nd, nd_cells, data_format] = ColorDescriptorsFileWrapper(image_url, exe_path)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
	detectors = {
		'harrislaplace',
		'densesampling'
	};
	
	descriptors = {
		'rgbhistogram',
		'opponenthistogram',
		'huehistogram',
		'nrghistogram',
		'transformedcolorhistogram',
		'colormoments',
		'colormomentinvariants',
		'sift',
		'huesift',
		'hsvsift',
		'opponentsift',
		'rgsift',
		'csift',
		'rgbsift'
	};
	    
    [image_path, name, ext] = fileparts(image_url);
    image_name = [name, ext];
    
    for i = 1 : length(descriptors)
		[nd_cells{i}, data_format{i}] = ColorDescriptorFileWrapper(image_url, exe_path, detectors{1}, descriptors{i});
    end
    
    [data_nd, n_group] = FeatureConcat(nd_cells);
end