function result = DbFeaBlock(image_path, image_names, block_len, border_len, zoom_sizes, func_image, para_image)
    for i = 1 : length(image_names)
        img = imread([image_path, image_names{i}]);
        
        if  isempty(zoom_sizes) 
            [data_nd, zmatrix, data_index, block_num] = ImageNd(img, block_len, border_len, func_image, para_image);
        elseif iscell(zoom_sizes)
            [nd_cells, zmatrix, data_index, block_num] = ImageNdScale(img, block_len, border_len, zoom_sizes, func_image, para_image);
            data_nd = transNdCellsToDataNd(nd_cells);
        elseif ((size(zoom_sizes) == [2, 1]) || (size(zoom_sizes) == [1, 2]))
            img = imresize(img, zoom_sizes);
            [data_nd, zmatrix, data_index, block_num] = ImageNd(img, block_len, border_len, func_image, para_image);
        end

        result{i}{1} = single(data_nd);
        result{i}{2} = data_index;
    end
end

function data_nd = transNdCellsToDataNd(nd_cells)
    data_nd = [];
    for i = 1 : length(nd_cells)
        data_nd = [data_nd; nd_cells{i}];
    end
end