function fitness = evalpopu(population)
%EVALPOPU Evaluation of the population's fitness values.
%	population: 
obj_fcn =  @(x)-1*(20+(x(1)/10).^2 + (x(2)/10).^2 - 10*(cos(2*pi*x(1)/10)+ cos(2*pi*x(2)/10)));;	% Objective function: 'rastriginfcn'
pop_n = size(population, 1);
fitness = zeros(pop_n, 1);
for count = 1:pop_n
    p =population(count,:);
	fitness(count) = obj_fcn(p);
end

end
