%  The Objective Function
%
%  y = f(x)
%
%  Arguments:
%  'x' should be 100 * 1 vector.
%
%  Returns:
%  'y' is the function value.
%
function y = f(x)

y = sum(x.*log(x));