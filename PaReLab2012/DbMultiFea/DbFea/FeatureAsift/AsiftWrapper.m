function [data_nd, data_format] = AsiftWrapper(img)
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
		
	file_img1 = image_url;
	file_img2 = image_url;
	img_out_vert = [cur_path, '\', 'img_out_vert.png'];
	img_out_hori = [cur_path, '\', 'img_out_hori.png'];
	matchings = [cur_path, '\', 'matchings.txt'];
	keys1 = [cur_path, '\', 'keys1.txt'];
	keys2 = [cur_path, '\', 'keys2.txt'];
	flag_resize = 0;

	demo_ASIFT(file_img1, file_img2, img_out_vert, img_out_hori, matchings, keys1, keys2, flag_resize);
        
    [data_nd, data_format] = readKeys(keys1);

    delete(image_url);
    delete(img_out_vert);
    delete(img_out_hori);
    delete(matchings);
    delete(keys1);
    delete(keys2);
end

function cur_path = getCurPath()
    cur_path = fileparts(mfilename('fullpath'));
end

function [data_nd, data_format] = readKeys(keys_file)
    fid = fopen(keys_file);
    A = fscanf(fid, '%d', 2);
    num1 = A(1);
    num2 = A(2);
    for i = 1 : num1
        C = textscan(fid, '%f', num2 + 4);
        data(i, :) = C{1}';
    end
    fclose(fid);
    
    data_nd = data(:, 5: end);
    data_format = data(:, 1: 4);
%     x = data(:, 1);
%     y = data(:, 2);
%     scale = data(:, 3);
%     theta = data(:, 4);
end