function [data_rn, trans_mat_rd] = PcaShao(data_dn, dimension)
	%Calculate cov matrix and the PCA matrixes
	C = cov(data_dn'); 
	[V D]=eig(C);
	trans_mat_rd =  diag(1./sqrt(diag(D((end-dimension+1):end,(end-dimension+1):end))))*V(:,(end-dimension+1):end)';
	uwhM = V(:,dimension:end)*diag(sqrt(diag(D(dimension:end,dimension:end))));

	%Calculate new features
	data_rn = trans_mat_rd * data_dn;
end