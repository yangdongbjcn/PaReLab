function [paths, label_names, image_names, image_labels] = DbInitMulti(top_path, data_folder, dataset_folder, image_folder, image_labels, label_names)
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
    
    
    real_names = ScanFolder(paths.image_path);
    [load_names, label_nums1, load_numlabels] = loadImageNumLabels(paths.imagelabels_file);
    mapping = adjustImageNames(real_names, load_names);
    
    image_names = real_names;
    image_numlabels = load_numlabels(mapping, :);	
	
	[label_nums2, load_label_names] = loadLabelNames(paths.labelnames_file);
	adjustLabelNames(label_nums1, label_nums2);
    label_names = load_label_names(label_nums1);
	
    new_numlabels = zeros(size(image_numlabels));
	for i = 1 : length(label_nums1)
		t_sel = image_numlabels == label_nums1(i);
		new_numlabels(t_sel) = i;
    end	
    image_labels = TransNumLabelToBinLabel(new_numlabels);    
	
	DbInitSave(paths.image_path, label_names, image_names, image_labels);
end

function [image_names, label_nums, image_numlabels] = loadImageNumLabels(imagelabels_file)
    cell_mat = textScanToCellMat(imagelabels_file);
    image_names = getImageNames(cell_mat);
    
    image_numlabels = getImageNumLabels(cell_mat);
    
    label_nums = unique(image_numlabels(:));
    label_nums = setdiff(label_nums, [0]);
end

function[label_nums, label_names] = loadLabelNames(labelnames_file)
	cell_mat = textScanToCellMat(labelnames_file);
	
	label_nums = getLabelNums(cell_mat);
	label_names = getLabelNames(cell_mat);
end

%% getLabelNums getLabelNames from cell_mat

function label_nums = getLabelNums(cell_mat)
    labelNumsString = cell_mat(:, 1);
	
    for i = 1 : length(labelNumsString)
		tmp1 = labelNumsString{i};
		label_nums(i) = str2num(tmp1);
    end
end

function label_names = getLabelNames(cell_mat)
    label_names = cell_mat(:, 2);
end

%% textScan

function cell_mat = textScanToCellMat(imagelabels_file)
    fid = fopen(imagelabels_file);
    i = 0;
    tline = fgetl(fid);
    while isValidLine(tline)
        i = i + 1;
        tmp1 = processEachLine(tline);    
        cell_array{i} = tmp1{:};
        tline = fgetl(fid);
    end
    fclose(fid);    
    cell_mat = cellArray2cellMat(cell_array);
end

function is_valid = isValidLine(tline)
    is_valid = ischar(tline) && ~isempty(tline);
end

function cell_mat = processEachLine(tline)
    cell_mat = textscan(tline, '%s');
end

function cell_mat = cellArray2cellMat(cell_array)
    max_len = findMaxLen(cell_array);
    cell_mat = cell(length(cell_array), max_len);
    for i = 1 : length(cell_array)
        tmp = length(cell_array{i});
        cell_mat(i,1:tmp) = cell_array{i};
    end
end

function max_len = findMaxLen(cell_array)
    max_len = 0;
    for i = 1 : length(cell_array)
        tmp = length(cell_array{i});
        if tmp > max_len
            max_len = tmp;
        end
    end
end

%% getImageNames getImageNumLabels from Cells

function image_names = getImageNames(cell_mat)
    image_names = cell_mat(:, 1);
end

function image_labels = getImageNumLabels(cell_mat)
    cells_new = cell_mat(:, 2:end);
    for i = 1 : size(cells_new, 1)
        for j = 1 : size(cells_new, 2)
            tmp1 = cells_new(i,j);
            tmp2 = tmp1{:};
            tmp3 = str2double(tmp2);
            cells_new(i,j) = num2cell(tmp3);
        end
    end
    image_labels = cell2mat(cells_new);
    
    image_labels(isnan(image_labels)) = 0;
end

%% adjust

function mapping = adjustImageNames(real_names, load_names)
	for i = 1 : length(real_names)
		tmp = strcmp(real_names{i}, load_names{i});
		assert(tmp);
	end
    mapping = 1 : length(real_names);   % dummy codes
end

function adjustLabelNames(label_nums1, label_nums2)
	adjustNoRepeated(label_nums1);
	adjustNoRepeated(label_nums2);
	
    tmp1 = setdiff(label_nums1, label_nums2);
    tmp2 = isempty(tmp1);
    assert(tmp2);
end

function adjustNoRepeated(label_nums)
	unique_len = length(unique(label_nums));
	len = length(label_nums);
	assert(unique_len == len);
end