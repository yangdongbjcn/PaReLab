function [precise, recall] = TranslateResult(annot_labels, real_labels)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    [precise, recall] = evalRetrieval( annot_labels', real_labels' );
    
    precise(isnan(precise)) = 0;
    recall(isnan(recall)) = 0;
end

