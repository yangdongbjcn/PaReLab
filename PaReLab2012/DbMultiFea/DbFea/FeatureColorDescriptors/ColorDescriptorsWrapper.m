function [data_nd, nd_cells, data_format] = ColorDescriptorsWrapper(img)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
	cur_path = getCurPath();
    addpath(genpath(cur_path));
	
    image_name = '_delete.jpg';
	image_url = [cur_path, '\', image_name];
	imwrite(img, image_url, 'jpg');
	
    exe_path = [cur_path, '/colordescriptors21/i386-win-vc/'];
	[data_nd, nd_cells, data_format] = ColorDescriptorsFileWrapper(image_url, exe_path);
    
%     n_group = [];
%     for i = 1 : length(nd_cells)
%         num = size(nd_cells{i}, 2);
%         n_group = [n_group, ones(1, num) * i];
%     end
%     save n_group;

    delete(image_url);
end

function cur_path = getCurPath()
    cur_path = fileparts(mfilename('fullpath'));
end