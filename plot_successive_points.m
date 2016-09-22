function out=plot_successive_points(xnew,xcurr)
hold on;
d= xnew-xcurr;
quiver(xcurr(1),xcurr(2),d(1),d(2),0);
drawnow; % Draws current graph now

out = [];