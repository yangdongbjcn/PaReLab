function DbInitSave(image_path, label_names, image_names, image_labels)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
    
    parent_path = [fileparts(fileparts(image_path)), '/'];
	save([parent_path, 'label_names.mat'], 'label_names');
	save([parent_path, 'image_names.mat'], 'image_names');
	save([parent_path, 'image_labels.mat'], 'image_labels');
end