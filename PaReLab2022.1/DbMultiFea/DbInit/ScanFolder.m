function image_names = ScanFolder(folder, is_dir, ext_name)
	if ~exist('is_dir', 'var')
		is_dir = false;
    end
    
    if ~exist('ext_name', 'var')
		ext_name = '';
	end

    fileList = dir(folder);
    j = 1;
    for i=1 : size(fileList,1)
        if isAnUsefulFile(fileList(i).name) && (fileList(i).isdir == is_dir)
            [pathstr, name, ext] = fileparts(fileList(i).name);
            if isempty(ext_name)
                image_names{j} = fileList(i).name;
                j = j + 1;
            else
                if strcmp(ext_name, ext)
                    image_names{j} = fileList(i).name;
                    j = j + 1;
                end
            end
        end
    end
end

function isUseful = isAnUsefulFile(fileName)
    isUseful = true;
    if (strcmp(fileName, 'Thumbs.db') || strcmp(fileName, '.') || strcmp(fileName, '..') || strcmp(fileName, '.svn') )
        isUseful = false;
        return;
    end
end