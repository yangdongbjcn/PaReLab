function [paths, label_names, image_names, image_labels] = DbInitLoad(top_path, data_folder, dataset_folder, image_folder, image_labels, label_names)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
            
    if ~exist('image_folder', 'var')
        image_folder = 'jpg';
    end
    
    if ~exist('image_labels', 'var')
        image_labels = 'image_labels.txt';
    end
    
    if ~exist('label_names', 'var')
        label_names = 'label_names.txt';
    end
    
    data_path = [top_path '/' data_folder '/'];
    
    paths = DbPathsLoad(data_path, dataset_folder, image_folder, image_labels, label_names);
    
    image_path = paths.image_path;
    parent_path = [fileparts(fileparts(image_path)), '/'];
	load([parent_path, 'label_names.mat'], 'label_names');
	load([parent_path, 'image_names.mat'], 'image_names');
	load([parent_path, 'image_labels.mat'], 'image_labels');
end