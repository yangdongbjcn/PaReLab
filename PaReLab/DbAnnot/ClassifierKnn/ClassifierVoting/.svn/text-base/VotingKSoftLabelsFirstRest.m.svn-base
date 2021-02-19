function id_l = VotingKSoftLabelsFirstRest(id_nl, k)
	% Compute average precision and recall
	KW = id_nl(1,:); % 最近的图像所带的关键词
	KW = find(KW);             
	KWTmp = id_nl(2:end, :); % 次近到k近的图像所带的关键词（可能重复）
	
	kwlocal = sum(KWTmp, 1);
	kwlocal = kwlocal / sum(kwlocal);
	kwave = kwlocal;
	[x,N] = sort(kwave, 'descend');
	N = N(x>0);
	N = setdiff(N, KW);          % 次近到k近的图像所带的关键词（不重复）
	id_l = [KW, N]; % then transfer keywords according to local frequency
	if(length(id_l)>k)
		id_l = id_l(1:k);           % 最近的关键词，次近到k近的前几个高频关键词，取前5个。
	end
end