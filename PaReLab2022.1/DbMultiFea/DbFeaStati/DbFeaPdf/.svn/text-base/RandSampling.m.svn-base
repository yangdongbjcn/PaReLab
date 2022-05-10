function sample_nd_cells = RandSampling(nd_cells, sample_num)

	num_img = length(nd_cells);
	num_per_img = round(sample_num/num_img);
	sample_num = num_per_img*num_img;

	for ii = 1:num_img,
		data_nd = nd_cells{ii};
		num_fea = size(data_nd, 1);
		
        if (num_fea > 0)
            while (num_fea < num_per_img)
                data_nd = [data_nd; data_nd];
                num_fea = size(data_nd, 1);
            end
            rndidx = randperm(num_fea);
            sample_nd_cells{ii} = data_nd(rndidx(1:num_per_img), :);
        else
            % if empty, use neighbor's data
            sample_nd_cells{ii} = sample_nd_cells{ii-1};
        end            
	end;
end
