function b = dyangDctZigzag(a, dir_cmd, size_b)
    % Zigzag a image (matrix)
    %
    % An example of zigzaging a image, 
	% b = dyang_zigzag(a, 'zr');
	%
	% An example of recoverying a image from a zigzag vector, 
	% b = dyang_zigzag(a, 'ar', size_b);
	%
	% To zigzag, use 'z', to anti-zigzag (recovery), use 'a'.
	% 
    % The 1st element is on the top-left,
	% if the 2nd element is on the right of the 1st element, use 'r',
	% if the 2nd element is on the bottom of the 1st element, use 'd'(down).
    %
    % code@dyang.com
    % Copyright (c) yangdong.bj.cn (2011). 
    % This software may be freely used and distributed for non-commercial
    % purposes.
    %    
    
    switch dir_cmd
        case 'zr'
            bb = dyangZigzag(size(a), 'r');
            b = a(bb);
        case 'ar'
            bb = dyangZigzag(size_b, 'r');
            b = zeros(size_b);
            tmp1 = bb(1:length(a));
            b(tmp1) = a;
        case 'zd'
            bb = dyangZigzag(size(a), 'd');
            b = a(bb);
        case 'ad'
            bb = dyangZigzag(size_b, 'd');
            b = zeros(size_b);
            tmp1 = bb(1:length(a));
            b(tmp1) = a;
    end
end

function b = dyangZigzag(size_a, dir_cmd)
    s1 = size_a(1);
    s2 = size_a(2);
    
    [X,Y] = meshgrid(1 : s1, 1 : s2);
    Z = (X + Y)';
    
    b = [];
    for i = 2 : s1+s2
        switch dir_cmd
            case 'r'
                if mod(i,2) == 0
                    tmp1 = find(Z == i);
                else
                    tmp1 = fliplr(find(Z == i)')';
                end
            case 'd'
                if mod(i,2) == 0
                    tmp1 = fliplr(find(Z == i)')';
                else
                    tmp1 = find(Z == i);
                end
        end
        b = [b; tmp1];
    end
end




