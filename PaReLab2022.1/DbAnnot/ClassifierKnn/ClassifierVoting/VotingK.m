function id_l = VotingK(id_nl, k)
	% Compute average precision and recall
	KW = id_nl(1,:); % 最近的图像所带的关键词
	KW = KW(KW~=0);             
	KWTmp = [];                  % 次近到k近的图像所带的关键词（可能重复）
	for j=2:size(id_nl,1)
		kwid = find(id_nl(j,:)~=0);
		KWTmp = [KWTmp, id_nl(j, kwid)];
	end
	kwlocal = hist(KWTmp, 1:1:max(KWTmp));
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