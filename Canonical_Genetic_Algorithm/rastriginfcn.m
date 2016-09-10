function z = rastriginfcn(input)
%PEAKSFCN The PEAKS function.
%	PEAKSFCN(INPUT) returns the value of the PEAKS function at the INPUT.
%	
%	See also PEAKS.

%	Roger Jang, 12-24-94.

global OPT_METHOD	% optimization method
global PREV_PT		% previous data point, used by simplex

x = input(1); y = input(2);
% The following function should be the same as the one in PEAKS.M.
z =  -1*(20+(x/10).^2 + (y/10).^2 - 10*(cos(2*pi*x/10)+ cos(2*pi*y/10)));
end

