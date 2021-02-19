function weights = DbFeaSelection(nd_cells, image_labels, cfg)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
	if ~exist('cfg', 'var')
		cfg = struct;
    end
    
    if ~isfield('cfg', 'method_name')
        method_name = 'sr';
    end
        
    % save & load   
    var_name = 'weights';
    file_name = [var_name method_name];
    try
        load(file_name, var_name);
    catch
        
        switch lower(method_name)
            case 'sr'
                weights = DbFeaSelectionSr(nd_cells, image_labels, cfg);
        end
        
        save(file_name, var_name);
    end

end
