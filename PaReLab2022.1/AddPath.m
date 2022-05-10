function cur_path = AddPath()
	%
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	clc;
	cur_path = getCurPath();
    addpath(genpath(cur_path));
end

function cur_path = getCurPath()
    cur_path = fileparts(mfilename('fullpath'));
end
