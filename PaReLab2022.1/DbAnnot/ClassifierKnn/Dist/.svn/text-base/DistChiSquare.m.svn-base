function dist = DistChiSquare(nd1, nd2, weights)
    temp_matrix = ((nd1==0).*(nd2==0));

	nd1 = nd1 + temp_matrix;
	nd2 = nd2 + temp_matrix;

	temp = (nd1-nd2).^2./(nd1+nd2);

	dist = sum(temp,2);
end