function [paths, label_names, image_names, image_labels] = DbInitSingle(top_path, data_folder, dataset_folder, image_folder, image_labels, label_names)
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
    label_names = ScanFolder(image_path, true);
    
    image_names = scanFolders(image_path, label_names);
    image_labels = transToImageLabels(image_names);
    image_names = combineFolderAndNames(label_names, image_names);
    
    DbInitSave(paths.image_path, label_names, image_names, image_labels);
end

%% image_names

function image_names = scanFolders(image_path, label_names)
    image_names = {};
    for i = 1 : length(label_names)
        image_names{i} = ScanFolder([image_path label_names{i} '/'], false);
    end
end

function image_labels = transToImageLabels(image_names)
    image_labels = [];
    labelNumber = length(image_names);
    for i = 1 : labelNumber
        len = length(image_names{i});
        tmp = zeros(len, labelNumber);
        tmp(:, i) = 1;
        image_labels = [image_labels; tmp];
    end
end

function new_names = combineFolderAndNames(label_names, image_names)
    new_names = {};
    k = 0;
    for i = 1 : length(label_names)
        for j = 1 : length(image_names{i})
            k = k + 1;
            new_names{k} = [label_names{i} '/' image_names{i}{j}];
        end
    end
end