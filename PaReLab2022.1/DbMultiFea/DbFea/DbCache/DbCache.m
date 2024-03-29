function result = DbCache(func, para, save_path, save_names, save_mode)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    if ~exist('save_mode', 'var')
        save_mode = 'single';
    end
    
    switch save_mode
        case 'single'
            result = cacheDataSingle(func, para, save_path);
        case 'multi_name'
            result = cacheDataMultiNames(func, para, save_path, save_names);
        case 'multi_name_big'
            result = cacheDataMultiNamesBig(func, para, save_path, save_names);
    end
end

%%

function result = cacheDataSingle(func, para, save_path)
    dataName = 'result';
    fileName = [save_path '/' dataName '.mat'];
    try
        load(fileName, dataName);
    catch
        result = func(para{:});
		mkdir(save_path);
        save(fileName, dataName, '-v7.3');
    end
end

%%

function result = cacheDataMultiNames(func, para, save_path, save_names)
    folder_name = 'result';
    folder_path = [save_path '/' folder_name '/'];
    value_name = 'value';
    try
        result = loadDataMultiNames(folder_path, value_name, save_names);
    catch
        result = func(para{:});
        saveDataMultiNames(result, folder_path, value_name, save_names);
    end
end

function result = loadDataMultiNames(folder_path, value_name, save_names)    
    for i = 1 : length(save_names)
        % name_len = 6; data_name = [sprintf(['%.' num2str(name_len) 'd'], i), '.mat'];
        data_name = [save_names{i}, '.mat'];
        data_file = [folder_path '/'  data_name];
        
        load(data_file, value_name);
        result{i} = value;
    end
end

function saveDataMultiNames(result, folder_path, value_name, save_names)
    for i = 1 : length(result)
        data_name = [save_names{i}, '.mat'];
        data_file = [folder_path '/'  data_name];
        
        makeFolder(data_file);
        value = result{i};
        save(data_file, value_name);
    end
end

%%

function result = cacheDataMultiNamesBig(func, para, save_path, save_names)
    func_input = para;
    para_cells = para{2};
    for i = 1 : length(para_cells)
        func_input{2} = para_cells(i);
        t_result = cacheDataMultiNames(func, func_input, save_path, save_names(i));
        result{i} = t_result{1};
    end
end

%% toolkit

function makeFolder(data_file)
    folder_path = fileparts(data_file);
    mkdir(folder_path);        
end