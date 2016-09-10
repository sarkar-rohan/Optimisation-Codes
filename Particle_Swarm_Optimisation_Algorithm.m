% Vectorised Particle Swarm Optimisation
% Author: Rohan Sarkar
clc;clear all;close all;
%% initialization
%%% define the objective funcion here (vectorized form)
objfcn =  @(x)(20+(x(:,1)/10).^2 + (x(:,2)/10).^2 - 10*(cos(2*pi*x(:,1)/10)+ cos(2*pi*x(:,2)/10)));
tic;
swarm_size = 441;                       % number of the swarm particles
maxIter = 100;                          % maximum number of iterations
inertia = 0.75;
correction_factor = 1.8;
% set the position of the initial swarm particles in 2D
faverage_values=zeros(maxIter+1,1);      %Stores the function values after every search
fbest_values=zeros(maxIter+1,1);      %Stores the function values after every search
fworst_values=zeros(maxIter+1,1);      %Stores the function values after every search
a = -10:10;
swarm(1:swarm_size,1,1) = 10*(2*rand(swarm_size,1)-ones(swarm_size,1));          % set the position of the particles in 2D
swarm(1:swarm_size,1,2) = 10*(2*rand(swarm_size,1)-ones(swarm_size,1));
swarm(:,2,:) = 0;                       % set initial velocity for particles
x = swarm(:, 1, 1);                                                                                  % get the updated position
y = swarm(:, 1, 2);                                                                                          % updated position
swarm(:,4,1) = objfcn([x y]);                                                                       % set the best value so far
swarm(:, 3, 1) = swarm(:, 1, 1);                                                                       % update best x position
swarm(:, 3, 2) = swarm(:, 1, 2);                                                                       % update best y postions
plotObjFcn = 0;                        % set to zero if you do not need a final plot
faverage = sum(swarm(:, 4, 1))/swarm_size                                  % find the average function value in total
[fbest, gbest] = min(swarm(:, 4, 1))                           % find the best function value in total
[fworst, gworst] = max(swarm(:, 4, 1))                          % find the worst function value in total
faverage_values(1,1)= faverage;
fbest_values(1,1)= fbest;
fworst_values(1,1)= fworst;

%% The main loop of PSO
for iter = 1:maxIter
    % update the velocity of the particles
    swarm(:, 2, 1) = inertia*(rand(swarm_size,1).*swarm(:, 2, 1)) + correction_factor*(rand(swarm_size,1).*(swarm(:, 3, 1) ...
        - swarm(:, 1, 1))) + correction_factor*(rand(swarm_size,1).*(swarm(gbest, 3, 1) - swarm(:, 1, 1)));   %x velocity component
    swarm(:, 2, 2) = inertia*(rand(swarm_size,1).*swarm(:, 2, 2)) + correction_factor*(rand(swarm_size,1).*(swarm(:, 3, 2) ...
        - swarm(:, 1, 2))) + correction_factor*(rand(swarm_size,1).*(swarm(gbest, 3, 2) - swarm(:, 1, 2)));   %y velocity component
    swarm(:, 1, 1) = swarm(:, 1, 1) + swarm(:, 2, 1);                                          %update x position with the velocity
    swarm(:, 1, 2) = swarm(:, 1, 2) + swarm(:, 2, 2);                                          %update y position with the velocity
    x = swarm(:, 1, 1);                                                                                  % get the updated position
    y = swarm(:, 1, 2);                                                                                          
    fval = objfcn([x y]);                                                % evaluate the function using the position of the particle
    
    % compare the function values to find the best ones
    for ii = 1:swarm_size
        if fval(ii,1) < swarm(ii,4,1)
            swarm(ii, 3, 1) = swarm(ii, 1, 1);                  % update best x position,
            swarm(ii, 3, 2) = swarm(ii, 1, 2);                  % update best y postions
            swarm(ii, 4, 1) = fval(ii,1);                       % update the best value so far
        end
    end
    faverage = sum(swarm(:, 4, 1))/swarm_size                      % find the average function value in total
    [fbest, gbest] = min(swarm(:, 4, 1))                           % find the best function value in total
    [fworst, gworst] = max(swarm(:, 4, 1))                          % find the worst function value in total
    faverage_values(iter+1,1)= faverage;
    fbest_values(iter+1,1)= fbest;
    fworst_values(iter+1,1)= fworst;
    
    % plot the particles
    figure(1)
    clf;plot(swarm(:, 1, 1), swarm(:, 1, 2), 'bx');             % drawing swarm movements
    axis([-15 15 -15 15]);
    pause(.1);                                                 
    disp(['iteration: ' num2str(iter)]);
end
%Plots of objective function values
fs = 15;
figure(1)
plot(fbest_values,'b-','linewidth',2);
xlim([1,maxIter]);
xlabel('$i$', 'interpreter', 'latex', 'FontSize', fs);
ylabel('$f(\mathbf{x})$','interpreter','latex','FontSize',fs);
set(gca, 'fontsize', fs-2, 'fontname', 'times');
hold on
fs = 15;
figure(1)
plot(faverage_values,'g.-','linewidth',2);
xlim([1,maxIter]);
xlabel('$i$', 'interpreter', 'latex', 'FontSize', fs);
ylabel('$f(\mathbf{x})$','interpreter','latex','FontSize',fs);
set(gca, 'fontsize', fs-2, 'fontname', 'times');
hold on
fs = 15;
figure(1)
plot(fworst_values,'rx-','linewidth',2);
xlim([1,maxIter]);
xlabel('$i$', 'interpreter', 'latex', 'FontSize', fs);
ylabel('$f(\mathbf{x})$','interpreter','latex','FontSize',fs);
set(gca, 'fontsize', fs-2, 'fontname', 'times');
legend('Best', 'Average', 'Poorest');
hold off
fs = 15;
figure(2)
plot(fbest_values,'b','linewidth',2);
xlim([1,maxIter]);
xlabel('$i$', 'interpreter', 'latex', 'FontSize', fs);
ylabel('$f(\mathbf{x})$','interpreter','latex','FontSize',fs);
set(gca, 'fontsize', fs-2, 'fontname', 'times');
fs = 15;
figure(3)
plot(faverage_values,'g.-','linewidth',2);
xlim([1,maxIter]);
xlabel('$i$', 'interpreter', 'latex', 'FontSize', fs);
ylabel('$f(\mathbf{x})$','interpreter','latex','FontSize',fs);
set(gca, 'fontsize', fs-2, 'fontname', 'times');

fs = 15;
figure(4)
plot(fworst_values,'rx-','linewidth',2);
xlim([1,maxIter]);
xlabel('$i$', 'interpreter', 'latex', 'FontSize', fs);
ylabel('$f(\mathbf{x})$','interpreter','latex','FontSize',fs);
set(gca, 'fontsize', fs-2, 'fontname', 'times');
