function paths = DbPathsLoad(data_path, dataset_folder, image_folder, image_labels, label_names)
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
    
    data_path = strrep(data_path, '\','/');
    data_path = [data_path '/'];
    paths.dataset_folder = dataset_folder;
    paths.dataset_path = [data_path  paths.dataset_folder '/'];
	paths.image_path = [paths.dataset_path image_folder '/'];
    paths.imagelabels_file = [paths.dataset_path image_labels];
    paths.labelnames_file = [paths.dataset_path label_names];
end