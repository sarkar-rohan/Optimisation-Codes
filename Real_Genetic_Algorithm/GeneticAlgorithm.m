%Program to implement Real Genetic Algorithm and minimize the
%Rastrigin Function over a search area of [?10 10] X [?10 10]
%Author:Rohan Sarkar
generation_n = 50;	% Number of generations
popuSize = 20;		% Population size
xover_rate = 0.75;	% Crossover rate
mutate_rate = 0.01;	% Mutation rate
bit_n = 16;		% Bit number for each input variable
global OPT_METHOD	% optimization method.
OPT_METHOD = 'ga';	% This is used for display in peaksfcn
obj_fcn =  @(x)-1*(20+(x(1)/10).^2 + (x(2)/10).^2 - 10*(cos(2*pi*x(1)/10)+ cos(2*pi*x(2)/10)));;	% Objective function: 'rastriginfcn'
var_n = 2;		% Number of input variables
range = [-10, 10; -10, 10];	% Range of the input variables
varSize = [1 var_n];
range_lower =-10;range_upper =10;
% Initial random population
popu = zeros(popuSize, 2);
for i =1:popuSize
    popu(i,:) = unifrnd(range_lower,range_upper,varSize); 
end
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
	fcn_value = evalpopu(popu);
	% Fill objective function matrices
	upper(i) = max(fcn_value);
	average(i) = mean(fcn_value);
	lower(i) = min(fcn_value);

	% display current best
	[best, index] = max(fcn_value);
	% generate next population via selection, crossover and mutation
	popu = nextpopu(popu, fcn_value, xover_rate, mutate_rate);
end
best
figure;
blackbg;
x = (1:generation_n)';
plot(x, -upper, 'o', x, -average, 'x', x, -lower, '*');
hold on;
plot(x, [-upper -average -lower]);
hold off;
legend('Best', 'Average', 'Poorest');
xlabel('Generations'); ylabel('Fitness');
