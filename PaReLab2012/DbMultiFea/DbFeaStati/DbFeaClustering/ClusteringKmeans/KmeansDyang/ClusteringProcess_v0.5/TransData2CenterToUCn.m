function u_cn = TransData2CenterToUCn(data2center)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
    center2data_cn = data2center';
    C = size(center2data_cn, 1);
    tmp_n = sum(center2data_cn, 1);
    tmp_cn = repmat(tmp_n, C, 1);
    u_cn = center2data_cn ./ tmp_cn;
end