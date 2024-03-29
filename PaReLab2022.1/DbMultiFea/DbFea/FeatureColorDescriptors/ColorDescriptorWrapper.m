function [data_nd, data_format] = ColorDescriptorWrapper(img, fea_name, detectors)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
	if ~exist('fea_name', 'var')
		fea_name = 'all';
	end
	
	if ~exist('detectors', 'var')
		detectors = 'harrislaplace';
		%detectors = 'densesampling';
	end
	
	cur_path = getCurPath();
    addpath(genpath(cur_path));
	
    image_name = '_delete.jpg';
	image_url = [cur_path, '\', image_name];
	imwrite(img, image_url, 'jpg');
	
    exe_path = [cur_path, '/colordescriptors21/i386-win-vc/'];
	[data_nd, data_format] = ColorDescriptorFileWrapper(image_url, exe_path, detectors, fea_name);

    delete(image_url);
end

function cur_path = getCurPath()
    cur_path = fileparts(mfilename('fullpath'));
end