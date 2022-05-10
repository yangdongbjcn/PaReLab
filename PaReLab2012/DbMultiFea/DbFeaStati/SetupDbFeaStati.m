function [func_feastati, para_feastati] = SetupDbFeaStati(struc_name, struc_para, data_format, zoom_size)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	    
    para_feastati = struc_para;
    
	switch lower(struc_name)
        case {'mean'}
            func_feastati = @DbFeaStatiMean;
        case {'cluster'}
            func_feastati = @DbFeaStatiCluster;
        case {'gmmnd'}
            func_feastati = @DbFeaStatiGmmCd;
        case {'ubmvec'}
            func_feastati = @DbFeaStatiUbmVec;
        case {'bof'}
            func_feastati = @DbFeaStatiBof;
        case {'scspm'}
            func_feastati = @DbFeaStatiScSpm;
            para_feastati = {struc_para{:}, data_format, zoom_size};
        case {'ubmbof'}
            func_feastati = @DbFeaStatiUbmBof;
            para_feastati = {struc_para{:}, data_format, zoom_size};
        case {'ubmspm'}
            func_feastati = @DbFeaStatiUbmSpm;
            para_feastati = {struc_para{:}, data_format, zoom_size};
        case {'pubmbof'}
            func_feastati = @DbFeaStatiPUbmBof;
            para_feastati = {struc_para{:}, data_format, zoom_size};
        case {'pubmspm'}
            func_feastati = @DbFeaStatiPUbmSpm;
            para_feastati = {struc_para{:}, data_format, zoom_size};
        case {'pmuubmbof'}
            func_feastati = @DbFeaStatiPmuUbmBof;
            para_feastati = {struc_para{:}, data_format, zoom_size};
%         case {'pmuubmspm'}
%             func_feastati = @DbFeaStatiPmuUbmSpm;
%             para_feastati = {struc_para{:}, data_format, zoom_size};
        case {'scubmbof'}
            func_feastati = @DbFeaStatiScUbmBof;
            para_feastati = {struc_para{:}, data_format, zoom_size};
        case {'scubmspm'}
            func_feastati = @DbFeaStatiScUbmSpm;
            para_feastati = {struc_para{:}, data_format, zoom_size};
        case {'scmuubmbof'}
            func_feastati = @DbFeaStatiScmuUbmBof;
            para_feastati = {struc_para{:}, data_format, zoom_size};
%         case {'scmuubmspm'}
%             func_feastati = @DbFeaStatiScmuUbmSpm;
%             para_feastati = {struc_para{:}, data_format, zoom_size};
        case {'spm'}
            func_feastati = @DbFeaStatiSpm;
            para_feastati = {struc_para{:}, data_format, zoom_size};
        otherwise
            func_feastati = @DbFeaStatiMean;
    end
end