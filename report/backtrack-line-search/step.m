%  One Step of Backtracking Line Search
%  xUpdated = step(x, a, b)
%
%  Arguments:
%  'x' should be 2 * 1 vector.
%  'a' should be the parameter of the stopping condition of step backtracking, 0 < a < 0.5.
%  'b' should be the parameter of the common radio of step backtracking, 0 < b < 1.
%
%  Returns:
%  'xUpdated' is x after iteration, an 2 * 1 vector.
%
function xUpdated = step(x, a, b)

% Negetive Gradient Direction
d = -gf(x);
d2 = gf(x)' * gf(x); % -d_k^2, or gf(x)^T*d
% Decide the Step
t = vpa(1, 30);
while(f(x + t * d) > f(x) - a * t * d2)
	t = t * b;
end
% Output
xUpdated = x + t * d;