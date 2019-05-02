%  The Objective Function
%
%  y = f(x)
%  y = f(x1, x2)
%
%  Arguments:
%  'x' should be 2 * 1 vector.
%  'x1' should be a number, as the 1st component of 'x'.
%  'x2' should be a number, as the 2nd component of 'x'.
%
%  Returns:
%  'y' is the function value.
%
function y = f(x, x2)

if(nargin == 1)
	y = vpa(exp(x(1) + 3 * x(2) - 0.1) + exp(x(1) - 3 * x(2) - 0.1) + exp(-x(1) - 0.1), 30);
end
if(nargin == 2)
	y = vpa(exp(x + 3 * x2 - 0.1) + exp(x - 3 * x2 - 0.1) + exp(-x - 0.1), 30);
end
