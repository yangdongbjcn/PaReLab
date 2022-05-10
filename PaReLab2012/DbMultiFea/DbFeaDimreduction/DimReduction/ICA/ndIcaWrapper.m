function data_nr = ndPcaWrapper(data_nd, output_dim)
    % call PCA.m, 'nd' means matrix with size of number * dim
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    tmp = ICA(single(data_nd)', output_dim, 0.01);
    data_nr = tmp';
end