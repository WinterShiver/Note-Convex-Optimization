%  One Step of Newton Descending (In a Feasible Path)
%
%  y = loopAble(x)
%
%  Arguments:
%  'x' should be 100 * 1 vector.
%  'A' is a provided parameter.
%  'b' is a provided parameter.
%  'e' is the expected error.
%
%  Returns:
%  'xUpdated' is the sequential points, and finally the result.
%  'lambdaSquare' is the Newton descending measurement.
%
function [xUpdated, lambdaSquare] = loopAble(x, A, b, e)

% Preparation and Parameters
[p, n] = size(A);
xUpdated = x;
alpha = 0.49;
beta = 0.5;

% Loop
count = 0;
while(1)
	% Descending Direction
	AA = [sgf(xUpdated), A'; A, zeros(p)];
	bb = [-gf(xUpdated); zeros(p, 1)];
	dx = inv(AA) * bb;
	dx = dx(1: n, 1);
	
	% Breaking the Loop
	lambdaSquare = dx' * sgf(xUpdated) * dx
	if(lambdaSquare <= 2 * e)
		break
	end
	count = count + 1

	% Step Length
	t = 1;
	while(f(xUpdated + t * dx) > f(xUpdated) - alpha * t * lambdaSquare)
		f(xUpdated + t * dx) - f(xUpdated)
		t = beta * t;
		pause(1)
	end
	t
	
	% Updating the Sequential Point
	xUpdated = xUpdated + t * dx;
	pause(2);
end
	


