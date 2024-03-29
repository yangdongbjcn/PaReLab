function [feaSet, grid_size] = blockSift(img, maxImSize, gridSpacing, patchSize, dictionarySize, numTextonImages, pyramidLevels, nrml_threshold)
    %
    % yangdongbjcn@hotmail.com
    %
    % Jianchao Yang's code is used.
    %

%==========================================================================
% usage: calculate the sift descriptors given the image directory
%
% inputs
% rt_img_dir    -image database root path
% rt_data_dir   -feature database root path
% gridSpacing   -spacing for sampling dense descriptors
% patchSize     -patch size for extracting sift feature
% maxImSize     -maximum size of the input image
% nrml_threshold    -low contrast normalization threshold
%
% outputs
% database      -directory for the calculated sift features
%
% Lazebnik's SIFT code is used.
%
% written by Jianchao Yang
% Mar. 2011, IFP, UIUC
%==========================================================================
    
    if ~exist('maxImSize', 'var')
        maxImSize = 1000;
    end
    if ~exist('gridSpacing', 'var')
        gridSpacing = 8;
    end
    if ~exist('patchSize', 'var')
        patchSize = 16;
    end 
    if ~exist('dictionarySize', 'var')
        dictionarySize = 200;
    end              
	if ~exist('numTextonImages', 'var')
        numTextonImages = 50;
    end
	if ~exist('pyramidLevels', 'var')
        pyramidLevels = 3;
    end
    if ~exist('nrml_threshold', 'var')
        nrml_threshold = 1;
		% low contrast region normalization threshold (descriptor length)
    end              
	
    
    I = img;
    if ndims(I) == 3,
        I = im2single(rgb2gray(I));
    else
        I = im2single(I);
    end;
    
    [im_h, im_w] = size(I);
            
    if max(im_h, im_w) > maxImSize,
        I = imresize(I, maxImSize/max(im_h, im_w), 'bicubic');
        [im_h, im_w] = size(I);
    end;
    
    % make grid sampling SIFT descriptors
    remX = mod(im_w-patchSize,gridSpacing);
    offsetX = floor(remX/2)+1;
    remY = mod(im_h-patchSize,gridSpacing);
    offsetY = floor(remY/2)+1;

    [gridX,gridY] = meshgrid(offsetX:gridSpacing:im_w-patchSize+1, offsetY:gridSpacing:im_h-patchSize+1);

    % find SIFT descriptors
    siftArr = sp_find_sift_grid(I, gridX, gridY, patchSize, 0.8);
    [siftArr, siftlen] = sp_normalize_sift(siftArr, nrml_threshold);

    feaSet.feaArr = siftArr';
    feaSet.x = gridX(:) + patchSize/2 - 0.5;
    feaSet.y = gridY(:) + patchSize/2 - 0.5;
    feaSet.width = im_w;
    feaSet.height = im_h;
    
    grid_size = size(gridX);
end