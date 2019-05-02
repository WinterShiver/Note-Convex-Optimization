% Environment Initialization
n = 100;
p = 30;
epsilon = 1e-2;
e = 1e-4;

% Generating A
A = 0.1 + rand(p, n);
while(rank(A) ~= p)
	A = 0.1 + rand(p, n);
end

% Generating xAble, xUnable and b
xAble = 0.1 + rand(n, 1);
b = A * xAble;
xUnable = 0.1 + rand(n, 1);
while(max(abs(A * xUnable)) <= epsilon)
	xUnable = rand(n, 1);
end

% Descending Process
[xUpdated, lambdaSquare] = loopAble(xAble, A, b, e)
