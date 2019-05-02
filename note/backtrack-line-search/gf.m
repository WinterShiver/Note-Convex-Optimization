%  The Gradient of the Objective Function
%  y = gf(x)
%  y = gf(x1, x2)
%
%  Arguments:
%  'x' should be 2 * 1 vector.
%  'x1' should be a number, as the 1st component of 'x'.
%  'x2' should be a number, as the 2nd component of 'x'.
%
%  Returns:
%  'y' is the function value, an 2 * 1 vector.
%
function y = gf(x, x2)

if(nargin == 1)
	y = [vpa(exp(x(1) + 3 * x(2) - 0.1) + exp(x(1) - 3 * x(2) - 0.1) - exp(-x(1) - 0.1), 30); vpa(3 * exp(x(1) + 3 * x(2) - 0.1) - 3 * exp(x(1) - 3 * x(2) - 0.1), 30)];
end
if(nargin == 2)
	y = [vpa(exp(x + 3 * x2 - 0.1) + exp(x - 3 * x2 - 0.1) - exp(-x - 0.1), 30); vpa(3 * exp(x + 3 * x2 - 0.1) - 3 * exp(x - 3 * x2 - 0.1), 30)];
end