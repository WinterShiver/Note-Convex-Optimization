%  One Step of Backtracking Line Search
%  [xProcess, xSolved, count] = backSearch(x, a, b, e)
%
%  Arguments:
%  'x' should be 2 * 1 vector.
%  'a' should be the parameter of the stopping condition of step backtracking, 0 < a < 0.5.
%  'b' should be the parameter of the common radio of step backtracking, 0 < b < 1.
%  'e' should be the expected error.
%
%  Returns:
%  'xProcess' corresponds to the points during the process, an 2 * (count + 1) vector.
%  'xSolved' is the final result, an 2 * 1 vector.
%  'count' is the loop time.
%
function [xProcess, xSolved, count] = backSearch(x, a, b, e)

xSolved = vpa(x, 30);
xProcess = [xSolved];
count = 0;
while(sum(abs(gf(xSolved))) > e)
	xSolved = step(xSolved, a, b)
	sum(abs(gf(xSolved)))
	count = count + 1;
	xProcess = [xProcess, xSolved];
end