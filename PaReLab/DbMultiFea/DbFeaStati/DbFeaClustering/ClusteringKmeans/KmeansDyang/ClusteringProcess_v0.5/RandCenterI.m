function rand_i = RandCenterI(N, C)
    % 
	% yangdongbjcn@hotmail.com
	% Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %

    rp = randperm(N);
    rand_i = rp(1:C);
end