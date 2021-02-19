function [data_nd, data_format] = ColorDescriptorFileWrapper(image_url, exe_path, detector_name, descriptor_name)
    %
    % yangdongbjcn@hotmail.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial purposes.
    %
	
	%colorDescriptor <image> --detector <detector> --descriptor <descriptor> --output <descriptorfile.txt>

	command = [exe_path, 'colorDescriptor %s --detector %s --descriptor %s --outputFormat binary --output %s'];
    command = regexprep(command, '\', '/');
    
    [image_path, name, ext] = fileparts(image_url);
    image_name = [name, ext];
    
	%output_name = [image_name, '_', descriptors{i}, '.txt'];
	output_name = [descriptor_name, '.txt'];
	output_url = [image_path, '/', output_name];
	
	cur_command = sprintf(command, image_url, detector_name, descriptor_name, output_url);
	[status, result] = system(cur_command);
	try
		[data_nd, data_format] = readBinaryDescriptors(output_url);        
	catch
		data_nd = [];
		data_format = [];
	end
end