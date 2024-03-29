function [paths, label_names, image_names, image_labels, nd_cells] = ...
			DbMultiFea(top_path, data_folder, dataset_folder, image_folder, ...
                comb_name, block_len, border_len, zoom_sizes, stati_para)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    func_init = SetupDbInit(dataset_folder); para_init = {top_path, data_folder, dataset_folder, image_folder};
    [paths, label_names, image_names, image_labels] = func_init(para_init{:});
    
    for i = 1 : length(comb_name)
        [fea_name, feastati_name] = strtok(comb_name{i}, '->'); feastati_name = feastati_name(3:end);
        [func_fea{i}, para_fea{i}] = SetupDbFea(fea_name, block_len, border_len, zoom_sizes);
        [db_fea{i}, paths] = cacheDbFea(paths, image_names, fea_name, func_fea{i}, para_fea{i});
        nd_cells{i} = transToNdCells(db_fea{i});
        try
            data_format{i} = transToDataFormat(db_fea{i});
        catch
            data_format{i} = [];
        end
        
        if ~isempty(feastati_name)
            [func_feastati{i}, para_feastati{i}] = SetupDbFeaStati(feastati_name, stati_para, data_format{i}, zoom_sizes{1});
            [db_feastati{i}, paths] = cacheDbFeaStati(paths, feastati_name, nd_cells{i}, image_labels, func_feastati{i}, para_feastati{i});
            nd_cells{i} = db_feastati{i}{1};
        end
    end
    
    nd_cells = TransHierCellsToCellMat(nd_cells);
end

function [db_fea, paths] = cacheDbFea(paths, image_names, fea_name, func_fea, para_fea)
    para_dbfea = {paths.image_path, image_names, para_fea{:}};
	
	paths.fea_path = [paths.dataset_path, fea_name, '/'];
    if ~exist(paths.fea_path,'dir')
        mkdir(paths.fea_path);
    end
    
    cd(paths.fea_path);
	
%     db_fea = DbCache(func_fea, para_dbfea, paths.fea_path, image_names, 'multi_name_big');
    db_fea = DbCache(func_fea, para_dbfea, paths.fea_path, [], 'single');
end

function nd_cells = transToNdCells(db_fea)
    for i = 1 : length(db_fea)
        nd_cells{i} = db_fea{i}{1};
    end
end

function data_format = transToDataFormat(db_fea)
    for i = 1 : length(db_fea)
        data_format{i} = db_fea{i}{2};
    end
end

function [db_feastati, paths] = cacheDbFeaStati(paths, feastati_name, nd_cells, image_labels, func_fea, para_fea)    
	para_dbfea = {nd_cells, image_labels, para_fea{:}};
	
	paths.fea_path = [paths.fea_path, feastati_name, '/'];   % The old fea_path is lost.
    
    if ~exist(paths.fea_path,'dir')
        mkdir(paths.fea_path);
    end
    
    cd(paths.fea_path);

    db_feastati = DbCache(func_fea, para_dbfea, paths.fea_path, [], 'single');
end