function result = DbFea(image_path, image_names, func_image, para_image, zoom_size)
    for i = 1 : length(image_names)
        img = imread([image_path image_names{i}]);
        if exist('zoom_size', 'var')
            img  = imresize(img, zoom_size{1});
        end
        
        % for global feature, no data_format, twice computation.
        try
            [data_nds, data_format] = func_image(img, para_image{:});
            result{i}{2} = data_format;
        catch
            data_nds = func_image(img, para_image{:});
            result{i}{2} = [];
        end
        
        if (size(data_nds, 3) ~= 1)
            data_nds = transDataNdsToNd(data_nds);
        end

        result{i}{1} = single(data_nds);
    end
end

function data_nd = transDataNdsToNd(data_nds)
    data_nd = [];
    for i = 1 : size(data_nds, 3)
        data_nd = [data_nd, data_nds(:,:,i)];
    end
end