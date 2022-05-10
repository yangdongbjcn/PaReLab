function weights = GetWeightsL2Reg(X, Y, lambda)

    XTX = X'*X;
    weights = pinv(XTX + lambda*eye(size(XTX))) * X' * Y;
    
end
