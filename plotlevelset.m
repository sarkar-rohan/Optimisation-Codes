%Function to plot level sets of f 
%Input:Function values after each iteration, lower and upper bound of
%display
function out = plotlevelset(fn_values,lower,upper) 
[X1,X2] = meshgrid(lower:0.025:upper, lower:0.025:upper);
F = 20+(X1/10).^2+(X2/10).^2-10*(cos(2*pi*X1/10)+cos(2*pi*X2/10));
figure(1)
contour(X1,X2,F,fn_values,'ShowText','on');
xlabel('$x_1$','Interpreter','latex');
ylabel('$x_2$','Interpreter','latex');
out =[];