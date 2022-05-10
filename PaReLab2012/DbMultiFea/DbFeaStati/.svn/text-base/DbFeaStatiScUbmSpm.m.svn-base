function result = DbFeaStatiScUbmSpm(nd_cells, image_labels, cluster_num, sample_num, data_format, zoom_size)
	
	result = DbFeaStatiUbm(nd_cells, image_labels, cluster_num, sample_num, 'sc');
	UBM = result{1};
	gmm_cells = result{2};
	
	for i = 1 : length(nd_cells)
		gm = gmm_cells{i};
		data_nd = nd_cells{i};

        [pdf_nc, t(i)] = ZeroPCluster(gm, data_nd);
		% gmm_bof_cells{i} = sum(pdf_nc, 1);
		
		
		sc_codes = pdf_nc';
		
		data_x = data_format{i}(:, 1);
        data_y = data_format{i}(:, 2);
        if max(data_x > 128)
            img_width = 192;
            img_height = 128;
        else
            img_width = 128;
            img_height = 192;
        end
		
		pyramid = [1, 2, 4];
		d1 = spm(sc_codes, pyramid, img_width, img_height, data_x, data_y);
		gmm_bof_cells{i} = d1';
		
	result{1} = gmm_bof_cells;
	result{2} = UBM;
	result{3} = gmm_cells;
    result{4} = t;
end