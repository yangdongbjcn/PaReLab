function func_init = SetupDbInit(dataset_folder)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
		
	switch lower(dataset_folder)
		case {lower('BnuCampus5s320x240'), lower('BnuIndoor')}
			func_init = @DbInitSingle;
		case {lower('BnuCampus5m320x240')}
			func_init = @DbInitMulti;
        case {lower('iaprtc12'), lower('iaprtc12_1950'), lower('Corel5k'), lower('Corel500')}
            func_init = @DbInitLoad;
    end
end