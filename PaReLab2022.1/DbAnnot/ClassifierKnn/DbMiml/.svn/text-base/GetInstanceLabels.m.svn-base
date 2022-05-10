function instance_labels = GetInstanceLabels(instance_data_map, data_labels, instance_id)
	if exist('instance_id', 'var')	
		data_id = TransInstanceToData(instance_id, instance_data_map);
		instance_labels = data_labels(data_id, :);
	else
		instance_labels = data_labels(instance_data_map, :);
	end	
end