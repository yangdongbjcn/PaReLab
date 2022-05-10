function y = TransInfToReal(x)
x(x(:) == -Inf) = realmin;
x(x(:) == Inf) = realmax;
y = x;
end