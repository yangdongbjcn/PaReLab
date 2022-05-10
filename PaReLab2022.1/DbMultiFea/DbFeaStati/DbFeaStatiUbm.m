function result = DbFeaStatiUbm(nd_cells, image_labels, cluster_num, sample_num, cfg_ubm)
	
    var_name = 'UBM';
	file_path = [pwd, '/', var_name, num2str(cluster_num)];
	try
		load(file_path, var_name);
	catch
		UBM = computeGlobalGmm(nd_cells, sample_num, cluster_num);
		save(file_path, var_name);
    end

    var_name2 = 'gmm_cells';
    file_path = [pwd, '/', var_name2];
    try
		load(file_path, var_name2);
    catch
        ubm_diag = TransGmmToDiagSigma(UBM);
        % gmmLogPdf(ubm_diag, sample_nd)
        avoid_non_psd = 1e-12;
        for i = 1 : length(nd_cells)
            data_nd = nd_cells{i};
            tic;
            gm = ubm2gmm(ubm_diag, data_nd, cfg_ubm);
            toc
            gmm_cells{i} = gm;	
        end
        save(file_path, var_name2);
    end
	
	result{1} = UBM;
	result{2} = gmm_cells;
end

function t_log = gmmLogPdf(gmm, data)
    t_likelihood = pdf(gmm, data);
    t_log = mean(TransInfToReal(log(t_likelihood)));
end

function UBM = computeGlobalGmm(nd_cells, sample_num, cluster_num)
	sample_nd_cells = RandSampling(nd_cells, sample_num);
	sample_nd_cells = reshape(sample_nd_cells, [length(sample_nd_cells), 1]);
	sample_nd = cell2mat(sample_nd_cells);
	UBM = nd2gm(sample_nd, cluster_num);
end