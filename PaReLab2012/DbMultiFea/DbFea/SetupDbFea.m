function [func_fea, para_fea] = SetupDbFea(fea_name, block_len, border_len, zoom_sizes)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
	
    [fea_name, post_name] = strtok(fea_name, '.'); post_name = post_name(2:end);
    
	[func_image, para_image] = setupImageFea(fea_name);
    
    [func_image, para_image] = setupImageFeaPost(func_image, para_image, post_name);
    
    switch lower(fea_name)
		case {'lbp', 'lbp32', 'dct', 'dct32'}
			func_fea = @DbFeaBlock;
			para_fea = {block_len, border_len, zoom_sizes, func_image, para_image};
		case {'color', 'color2', 'hist', 'rgbhist', 'rgb_hist', ...
                'asift', 'asift_ip', ...
                'rgbhistogram',...
                'opponenthistogram',...
                'huehistogram',...
                'nrghistogram',...
                'transformedcolorhistogram',...
                'colormoments',...
                'colormomentinvariants',...
                'sift',...
                'huesift','colors14_ds_huesift',...
                'hsvsift',...
                'opponentsift',...
                'rgsift',...
                'csift','colors14_ds_csift', ...
                'rgbsift'}
			func_fea = @DbFea;
			para_fea = {func_image, para_image, zoom_sizes};
        case {}
            func_fea = @DbFeaBlock;
			para_fea = {block_len, border_len, zoom_sizes, func_image, para_image};
        otherwise
            func_fea = @funcDummy;
            para_fea = {};
    end
end

function varargout = funcDummy(varargin)
    varargout = varargin;
end

function [func_image, para_image] = setupImageFeaPost(func_image, para_image, post_name)
    
    func_pre = func_image;
    para_pre = para_image;
    switch post_name
        case 'post'
            func_image = @funcPost;
            cluster_num = 8;
			para_image = {func_pre, para_pre, cluster_num};
    end
end

function y = funcPost(img, func_pre, para_pre, cluster_num)
    x = func_pre(img, para_pre{:});
    y = x;
end

function [func_image, para_image] = setupImageFea(fea_name)
    para_image = {}; 
    switch lower(fea_name)
		case {'lbp', 'lbp32'}
			func_image = @LbpWrapper;
        case {'dct', 'dct32'}
			func_image = @rgb2ndDct;
        case {'color', 'color2'}
            func_image = @ColorDescriptorsWrapper;
		case {'rgbhistogram',...
                'opponenthistogram',...
                'huehistogram',...
                'nrghistogram',...
                'transformedcolorhistogram',...
                'colormoments',...
                'colormomentinvariants',...
                'sift',...
                'huesift',...
                'hsvsift',...
                'opponentsift',...
                'rgsift',...
                'rgbsift'}
			func_image = @ColorDescriptorWrapper;
            para_image = {fea_name}; 
        case {'csift','colors14_ds_csift'}            
			func_image = @ColorDescriptorWrapper;
            para_image = {'csift'}; 
        case { 'huesift','colors14_ds_huesift'}            
			func_image = @ColorDescriptorWrapper;
            para_image = {'huesift'};
        case {'hist', 'rgbhist', 'rgb_hist'}
			func_image = @ColorHist;
        case {'asift', 'asift_ip'}
            func_image = @AsiftWrapper;
        otherwise
            func_image = @funcDummy;
    end
end