%Conjugate Gradient Algorithm
%Author : Rohan Sarkar
function [x,N]=conjugate_gradient(grad, xnew, options);
%Initialising parameters and setting tolerance limits
numvars = length(xnew);
format compact;
format short g;
epsilon_x = 0.0001;
epsilon_g = 0.0001;
max_iter=50;
N=10;
fn_values=zeros(N,1);      %Stores the function values after every search.
x_values=zeros(2,N);                                   %Stores the points.
%Plotting Start Point on Graph
if length(xnew) == 2
    plot(xnew(1),xnew(2),'o')
    text(xnew(1),xnew(2),'Start Point')
end
g_curr=feval(grad,xnew);
if norm(g_curr) <= epsilon_g
  disp('Terminating: Norm of initial gradient less than');
  disp(epsilon_g);
  return;
end %if
d=-g_curr;                     %Set initial direction as negative gradient
reset_cnt = 0;
for k = 1:max_iter,
  xcurr=xnew;                              %set new point as current point
  x_values(:,k)=xcurr;                                %update search point
  fn_values(k,1)=f(x_values(:,k));                 %compute function value
  % Find the step size alpha 
  [a,b]= bracket(xcurr,-g_curr);                    %call bracket function
  alpha=gsection(a,b,xcurr,-g_curr);         %call golden section function
  %calculate new point along new direction
  xnew = xcurr+alpha*d; 
  g_old=g_curr;
  g_curr=feval(grad,xnew);               %calculate gradient of new point
  %Terminate Algorithm if Norm of the gradient at the new point is less 
  %than 0.0001
  if norm(g_curr) <= epsilon_g
    disp('Terminating: Norm of gradient less than');
    disp(epsilon_g);
    k=k-1;
  break;
  end %if
  %Printing Intermediate Values
  print_values(k,alpha,g_curr,xnew)
  reset_cnt = reset_cnt+1;
  if reset_cnt == 3*numvars
    d=-g_curr;
    reset_cnt = 0;
  else
    if options == 0 %Powell
      beta = max(0,(g_curr'*(g_curr-g_old))/(g_old'*g_old));
    elseif options == 1 %Fletcher-Reeves
      beta = (g_curr'*g_curr)/(g_old'*g_old);
      disp('fr');
    elseif options == 2 %Polak-Ribiere
      beta = (g_curr'*(g_curr-g_old))/(g_old'*g_old);
      disp('pr');
    else %Hestenes-Stiefel
      beta = (g_curr'*(g_curr-g_old))/(d'*(g_curr-g_old));
    end %if
    %calculating new direction
    d=-g_curr+beta*d;
  end
    disp('New beta =');
    disp(beta);
    disp('New d =');
    disp(d);         
  %Terminate Algorithm if Norm of difference between points iterates less 
  %than 0.0001
  if norm(xnew-xcurr) <= epsilon_x*norm(xcurr)
    disp('Terminating: Norm of difference between iterates less than');
    disp(epsilon_x);
    break;
  end %if
  %Terminate Algorithm if maximum number of iterations has been reached
  if k == max_iter
    disp('Terminating with maximum number of iterations');
  end %if
  %Plotting Intermediate Points on the graph
  figure(1)
  hold on;
  plot_successive_points(xnew,xcurr);
end %for
%Plotting contour lines and locating points on level sets
plotlevelset(fn_values,7,11);
%Returning values from function
if nargout >= 1
  x=xnew;
  if nargout == 2
    N=k;
  end 
end %if
  disp('Final point ='); 
  disp(xnew'); 
  disp('Number of iterations ='); 
  disp(k); 

end