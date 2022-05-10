function center_cd = TransDataNdAndUCnToCenterCd(data_nd, u_cn, m)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
	if ~exist('m', 'var') m = 2; end
	
	u_m = u_cn .^ m;
	center_cd = u_m * single(data_nd) ./ (u_m * ones(size(data_nd)));
end
