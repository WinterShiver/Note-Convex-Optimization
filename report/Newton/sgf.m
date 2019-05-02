%  The Second Gradient of Objective Function
%
%  y = sgf(x)
%
%  Arguments:
%  'x' should be 100 * 1 vector.
%
%  Returns:
%  'y' is the 100 * 1 feature vector of the function value, which is an 100 * 100 matrix.
%
function y = sgf(x)

y = zeros(length(x), length(x));
for i=1: length(x)
	y(i, i) = 1 / x(i);
end