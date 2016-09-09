%MATLAB Routine for DFP Algorithm
%Author : Rohan Sarkar
function [x,N]=DFP(grad,xnew);
%Initialising parameters and setting tolerance limits
format compact;
format short g;
epsilon_g = 0.0001;
max_iter=50;
N=10;
fn_values=zeros(N,1);      %Stores the function values after every search.
x_values=zeros(2,N);                                   %Stores the points.
A = eye(2);
%Plotting Start Point on Graph
if length(xnew) == 2
  plot(xnew(1),xnew(2),'o')
  text(xnew(1),xnew(2),'Start Point')
end
%Calculate gradient at initial point
g_curr=feval(grad,xnew);
%Terminate Algorithm if Norm of the gradient at the initial point is less 
%than 0.0001
if norm(g_curr) <= epsilon_g
  disp('Terminating: Norm of initial gradient less than');
  disp(epsilon_g);
  return;
end 

for k = 1:max_iter,
  xcurr=xnew;                        %set new point as current point
  d=-A*g_curr;                              %Calculate new direction
  x_values(:,k)=xcurr;                                %update search point
  fn_values(k,1)=f(x_values(:,k));                 %compute function value
  % Find the step size alpha 
  [a,b]= bracket(xcurr,d);                  %call bracket function
  alpha=gsection(a,b,xcurr,d);       %call golden section function
  %calculate new point along new direction
  xnew = xcurr+alpha*d;
  %Printing Intermediate Values
  print_values(k,alpha,g_curr,xnew)
  dx = alpha*d;     %calculate difference between new and old point
  g_old=g_curr;
  g_curr=feval(grad,xnew);   %calculating gradient at new point
  %calculate difference between the gradient at new and old point
  dg = g_curr - g_old;
  %Calculating successive approximation of inverse of Hessian
  Y= A*dg;
  Z = (Y*Y.')/(dg.'*Y);
  C = (dx*dx.')/(dx.'*dg);
  Anew = A+C-Z;
  A = Anew
  %Terminate Algorithm if Norm of the gradient at the new point is less 
  %than 0.0001
  if norm(g_curr) <= epsilon_g
    disp('Terminating: Norm of gradient less than');
    disp(epsilon_g);
    break;
  end %if
  figure(1)
  hold on;
  plot_successive_points(xnew,xcurr);
  %Terminate Algorithm if maximum number of iterations has been reached
  if k == max_iter
    disp('Terminating with maximum number of iterations');
  end %if
end %for
%Plotting contour lines and locating points on level sets
plotlevelset(fn_values,-11,-6.5);
%Returning values from function
if nargout >= 1
  x=xnew;
  if nargout == 2
    N=k;
  end 
end
  disp('Final point ='); 
  disp(xnew'); 
  disp('Number of iterations ='); 
  disp(k); 
end %if