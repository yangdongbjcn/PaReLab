function dist = DistL0(nd1, nd2, zero_thres)
    if ~exist('zero_thres', 'var')
        zero_thres = 1e-6;
    end

    dist_mat = abs(nd1 - nd2);
    non_zero = find(dist_mat > zero_thres);
    nz_dnum = sum(non_zero, 2);
    
    dist = nz_dnum;
end