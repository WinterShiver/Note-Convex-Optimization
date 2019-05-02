% The Graph of Objective Function
[xx, yy] = meshgrid(-3: 0.1: 1, -1: 0.1: 1);
mesh(xx, yy, double(f(xx, yy)));
title('The Graph of Objective Function')
x1=xlabel('x1')
x2=ylabel('x2')
x3=zlabel('f(x)')

% First Try
[xProcess, xSolved, count] = backSearch([1; 1], 0.25, 0.5, 1e-3);
plot(xProcess(1, :), xProcess(2, :))

% Prepare Data
initList = [[-0.47; 0.10], [-0.33; 0.03], [-0.36; 0.01]];
eList = [1e-2, 1e-3, 1e-4];
aList = [0.05, 0.15, 0.25, 0.35, 0.45];
bList = [0.1, 0.3, 0.5, 0.7, 0.9];
colorList = ['r', 'g', 'b', 'y', 'k'];

% Available
countMatrix = zeros(3);
a = 0.25; b = 0.5;
for i = 1: 3
	for j = 1: 3
		[xProcess, xSolved, count] = backSearch(initList(:, i), a, b, eList(4 - j));
		plot(xProcess(1, :), xProcess(2, :), colorList(j))
		hold on
		countMatrix(i, j) = count
	end
end

% Alpha
countMatrix = zeros(5, 1);
x = [-0.47; 0.10]; b = 0.5; e = 1e-2;
for j = 1: 5
	[xProcess, xSolved, count] = backSearch(x, aList(j), b, e);
	plot(xProcess(1, :), xProcess(2, :), colorList(j))
	hold on
	countMatrix(j, 1) = count
end

% Beta
countMatrix = zeros(5, 1);
timeMatrix = zeros(5, 1);
x = [-0.47; 0.10]; a = 0.25; e = 1e-2;
for j = 1: 5
	timej = cputime;
	[xProcess, xSolved, count] = backSearch(x, a, bList(j), e);
	plot(xProcess(1, :), xProcess(2, :), colorList(j))
	hold on
	countMatrix(j, 1) = count
	timeMatrix(j, 1) = cputime - timej
end