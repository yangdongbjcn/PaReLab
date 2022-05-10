function id_l = VotingKSoftLabelsFirstRest(id_nl, k)
	% Compute average precision and recall
	KW = id_nl(1,:); % �����ͼ�������Ĺؼ���
	KW = find(KW);             
	KWTmp = id_nl(2:end, :); % �ν���k����ͼ�������Ĺؼ��ʣ������ظ���
	
	kwlocal = sum(KWTmp, 1);
	kwlocal = kwlocal / sum(kwlocal);
	kwave = kwlocal;
	[x,N] = sort(kwave, 'descend');
	N = N(x>0);
	N = setdiff(N, KW);          % �ν���k����ͼ�������Ĺؼ��ʣ����ظ���
	id_l = [KW, N]; % then transfer keywords according to local frequency
	if(length(id_l)>k)
		id_l = id_l(1:k);           % ����Ĺؼ��ʣ��ν���k����ǰ������Ƶ�ؼ��ʣ�ȡǰ5����
	end
end