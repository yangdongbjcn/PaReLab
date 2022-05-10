function result = DbFeaStatiScBof(nd_cells, image_labels, cluster_num, sample_num, data_format, zoom_size)
% 	sample_nd_cells = RandSampling(nd_cells, sample_num);
%     sample_nd_cells = reshape(sample_nd_cells, [length(sample_nd_cells), 1]);
%     sample_nd = cell2mat(sample_nd_cells); 
%     
%     var_name = {'center_cd'};
%     file_name = 'feastati_scbof';
%     file_path = [pwd, '/', file_name];
%     try
%         load(file_path, var_name{:});
%     catch
%         [center_cd, u_cn] = GetDictLasso(sample_nd, cluster_num);
%         
%         save(file_path, var_name{:});
%     end
%     
%     gamma = 0.15;
%     % spatial block number on each level of the pyramid
%     pyramid = [1, 2, 4];
%     % find the k-nearest neighbors for approximate sparse coding
%     % if set 0, use the standard sparse coding
%     knn = 0;
%         
%     % data_label
%     for i = 1 : length(nd_cells)
%         if ~mod(i, 50),
%             fprintf('.\n');
%         else
%             fprintf('.');
%         end;
% 
%         feaSet.feaArr = nd_cells{i}';
%         feaSet.x = data_format{i}(:, 1);
%         feaSet.y = data_format{i}(:, 2);
% %         feaSet.width = zoom_size(1);
% %         feaSet.height = zoom_size(2);
%         if max(feaSet.x > 128)
%             feaSet.width = 192;
%             feaSet.height = 128;
%         else
%             feaSet.width = 128;
%             feaSet.height = 192;
%         end
%         
%         if knn,
%             sc_fea(:, i) = sc_approx_pooling(feaSet, center_cd', pyramid, gamma, knn);
%         else
%             sc_fea(:, i) = sc_pooling(feaSet, center_cd', pyramid, gamma);
%         end
%     end
%     data_nd = sc_fea';
%     len_arr = ones(1, length(nd_cells));
%     new_cells = TransDataNdAndLengthsToCells(data_nd, len_arr);
%     result{1} = new_cells;
%     result{2} = center_cd;
end