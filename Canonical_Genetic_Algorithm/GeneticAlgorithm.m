%Program to implement Canonical Genetic Algorithm and minimize the
%Rastrigin Function over a search area of [?10 10] X [?10 10]
% Author: Rohan Sarkar
% This is based on the original code by Roger Jang
generation_n = 50;	% Number of generations
popuSize = 20;		% Population size
xover_rate = 0.75;	% Crossover rate
mutate_rate = 0.01;	% Mutation rate
bit_n = 16;		% Bit number for each input variable
global OPT_METHOD	% optimization method.
OPT_METHOD = 'ga';	% This is used for display in peaksfcn
obj_fcn = 'rastriginfcn';	% Objective function: 'rastriginfcn'
var_n = 2;		% Number of input variables
range = [-10, 10; -10, 10];	% Range of the input variables
% Initial random population
popu = rand(popuSize, bit_n*var_n) > 0.5; 
upper = zeros(generation_n, 1);
average = zeros(generation_n, 1);
lower = zeros(generation_n, 1);

% Main loop of GA
for i = 1:generation_n;

	% delete unnecessary objects
	delete(findobj(0, 'tag', 'member'));
	delete(findobj(0, 'tag', 'individual'));
	delete(findobj(0, 'tag', 'count'));

	% Evaluate objective function for each individual
	fcn_value = evalpopu(popu, bit_n, range, obj_fcn);
	% Fill objective function matrices
	upper(i) = max(fcn_value);
	average(i) = mean(fcn_value);
	lower(i) = min(fcn_value);

	% display current best
	[best, index] = max(fcn_value);
	fprintf('Generation %i: ', i);
	fprintf('f(%f, %f)=%f\n', ...
	bit2num(popu(index, 1:bit_n), range(1,:)), ...
	bit2num(popu(index, bit_n+1:2*bit_n), range(2,:)), ...
			best);
	% generate next population via selection, crossover and mutation
	popu = nextpopu(popu, fcn_value, xover_rate, mutate_rate);
end
%Plots of objective function values
fs = 15;
figure(1)
count=(1:generation_n)';
plot(count,-upper,'o-',count,-average,'x-',count,-lower,'*-','linewidth',2);
xlim([1 N]);
legend('best','average','worst');
xlabel('$i$', 'interpreter', 'latex', 'FontSize', fs);
ylabel('$f(\mathbf{x})$','interpreter','latex','FontSize',fs);
set(gca, 'fontsize', fs-2, 'fontname', 'times');

