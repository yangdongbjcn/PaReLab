function data2center = TransDataNdAndCenterCdToData2Center(data_nd, center_cd)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
    C = size(center_cd, 1);
    N = size(data_nd, 1);
    for i=1:C,
        vd = single(data_nd) - single(repmat(center_cd(i,:), N, 1));
        data2center(:,i) = sum(abs(vd).^2, 2);
    end;
end

