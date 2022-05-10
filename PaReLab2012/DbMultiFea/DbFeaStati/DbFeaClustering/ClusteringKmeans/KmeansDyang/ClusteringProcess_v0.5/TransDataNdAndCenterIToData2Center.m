function data2center = TransDataNdAndCenterIToData2Center(data_nd, center_i)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %

    center_cd = data_nd(center_i, :);
    
	data2center = TransDataNdAndCenterCdToData2Center(data_nd, center_cd);
end

