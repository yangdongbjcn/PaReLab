function [data_nd, data_index] = blockSiftWrapper(img, varargin)
    
    [feaSet, grid_size] = blockSift(img, varargin{:});
    
    data_nd = feaSet.feaArr';
    data_index = produceIndex(grid_size(1), grid_size(2));
end

function data_index = produceIndex(size1, size2, direction)
    if ~exist('direction', 'var')
        direction = 'col';
    end
    
    switch lower(direction)
        case 'col'
            data_index = [];
            for i = 1 : size2
                tmp1 = [(1:size1)', ones(size1, 1)*i];
                data_index = [data_index; tmp1];
            end
        case 'row'
            data_index = [];
            for i = 1 : size1
                tmp1 = [ones(size2, 1)*i, (1:size1)'];
                data_index = [data_index; tmp1];
            end
    end
end