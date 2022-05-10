function [data_nr, trans_mat_dr] = ndPcaShaoWrapper(data_nd, output_dim)
    % call PcaShao.m, 'nd' means matrix with size of number * dim
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
	[data_rn, trans_mat_rd] = PcaShao(single(data_nd)', output_dim);
    data_nr = data_rn';
    trans_mat_dr = trans_mat_rd';
end