function [mask_ng, mask_upper, mask_lower] = FindNonDiag(mat_size)
    mask = ones(mat_size);
    mask_ng = mask - diag(diag(mask));
    mask_upper = triu(mask, 1);
	mask_lower = tril(mask, -1);
end