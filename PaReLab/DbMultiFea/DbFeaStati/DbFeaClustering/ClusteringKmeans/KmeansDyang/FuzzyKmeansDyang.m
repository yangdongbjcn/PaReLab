function [data_label, center_cd, u_cn] = FuzzyKmeansDyang(data_nd, C, max_iter)
    % 
	% yangdongbjcn@hotmail.com
	% Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    N = size(data_nd,1);
    center_i = RandCenterI(N, C);
    center_cd = data_nd(center_i, :);

    for j=1:max_iter
        data2center = TransDataNdAndCenterCdToData2Center(data_nd, center_cd);
        
        u_cn = TransData2CenterToUCn(data2center);
        
        center_cd = TransDataNdAndUCnToCenterCd(data_nd, u_cn);
    end;
    
    data_label = TransData2CenterToDataLabel(data2center);
end