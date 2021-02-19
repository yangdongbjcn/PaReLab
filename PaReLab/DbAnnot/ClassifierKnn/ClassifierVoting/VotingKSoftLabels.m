function id_l = VotingKSoftLabels(id_nl, k)
	% Compute average precision and recall           
	KWTmp = id_nl; % �����k����ͼ�������Ĺؼ��ʣ������ظ���
	
	kwlocal = sum(KWTmp, 1);
	kwlocal = kwlocal / sum(kwlocal);
	kwave = kwlocal;
	[x,N] = sort(kwave, 'descend');
	N = N(x>0);
    
	id_l = [N]; % then transfer keywords according to local frequency
	if(length(id_l)>k)
		id_l = id_l(1:k);           % ����Ĺؼ��ʣ��ν���k����ǰ������Ƶ�ؼ��ʣ�ȡǰ5����
	end
end