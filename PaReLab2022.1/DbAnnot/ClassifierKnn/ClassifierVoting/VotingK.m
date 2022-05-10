function id_l = VotingK(id_nl, k)
	% Compute average precision and recall
	KW = id_nl(1,:); % �����ͼ�������Ĺؼ���
	KW = KW(KW~=0);             
	KWTmp = [];                  % �ν���k����ͼ�������Ĺؼ��ʣ������ظ���
	for j=2:size(id_nl,1)
		kwid = find(id_nl(j,:)~=0);
		KWTmp = [KWTmp, id_nl(j, kwid)];
	end
	kwlocal = hist(KWTmp, 1:1:max(KWTmp));
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