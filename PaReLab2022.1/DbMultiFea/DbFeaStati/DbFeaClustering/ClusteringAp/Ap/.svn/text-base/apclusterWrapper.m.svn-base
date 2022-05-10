function [data_label, center_i, clustering_measure] = apclusterWrapper(S, max_iter, lam)
	if ~exist('max_iter','var')
        max_iter = 500;
    end
	if ~exist('lam','var')
		lam = 0.5; % Set damping factor
    end
	
	[s, p] = seperateSP(S);
	[data_label,netsim,dpsim,expref] = apcluster(s,p);
	
	center_i = unique(data_label);		
	[data_label, cluster_size] = SortDataLabel(data_label);
    data_label = reshape(data_label, length(data_label),1);
	
	sim_c = TransSimMatrixIdxToSimC(S, data_label);
	clustering_measure = sum(sim_c);
end

function [s, p] = seperateSP(S)
	p = diag(S);
	s = S - diag(p);
end