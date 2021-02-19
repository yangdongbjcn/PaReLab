function b = ImageBlkproc(varargin)
	fun = varargin{4};
    if length(varargin) >= 5
        params = varargin(5:end);
    end
	
	x = magic(10);
	x3 = cat(3, x, x, x);
    if length(varargin) >= 5
        y = fun(x3, params{:});
    else
        y = fun(x3);
    end
	
	if (size(y, 3) == 1)
		b = ImageBlkprocMat(varargin{:});
	else
		b = ImageBlkprocImage(varargin{:});
	end
end