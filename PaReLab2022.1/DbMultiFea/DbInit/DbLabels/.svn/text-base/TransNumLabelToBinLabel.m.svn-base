function image_labels = TransNumLabelToBinLabel(image_numlabels, label_num)
	if ~exist('label_num')
		label_num = max(image_numlabels(:));
	else
		real_num = max(image_numlabels(:));
		if label_num < real_num
			label_num = real_num;
		end
	end

    image_labels = zeros(size(image_numlabels, 1), label_num);
    for i = 1 : size(image_numlabels, 1)
        for j = 1 : size(image_numlabels, 2)
            if image_numlabels(i,j) ~= 0
                image_labels(i, image_numlabels(i,j)) = 1;
            end
        end    
    end
end