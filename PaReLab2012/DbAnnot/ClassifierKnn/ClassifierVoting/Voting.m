function id_voted = Voting(id_k)
    id_k = id_k(id_k ~= 0);
    unique_group = unique(id_k);
    if length(unique_group) == 1 
        id_voted = unique_group;
        return;
    end
    unique_count = hist(id_k, unique_group);
    [B, unique_no] = sort(unique_count, 'descend');
    if B(1) == B(2)
        id_voted = id_k(1);
        return;
    else
        id_voted = unique_group(unique_no(1));
        return;
    end    
end