% This method bracket finds an interval in which the minimizer will exist.
% Input arguments: the initial search point x0,the search direction d. 
% Output: interval [a,b] containing the minimizer/maximizer.
% Author: Rohan Sarkar
function [a,b]= bracket(x0,d)
N=50;                                           %Maximum no of iterations 
epsilon = 0.1;
fn_values=zeros(N,1);      %Stores the function values after every search
x_values=zeros(2,N);                            %Stores the search points
count = 0;                                         %Reset the count value
x_values(:,1)=x0;  %Initialization of the x_values array with first point
fn_values(:,1)= f(x0);                  %Function value at starting point
for i=1:N
    x_values(:,i+1)=x_values(:,i)+2^(i-1)*epsilon*d; %Update search point
    fn_values(i+1,1)=f(x_values(:,i+1));          %Compute function value
    count = count+1;                          %Increment count value by 1
    %Check loop breaking criterion that is if the successive value
    %increases with respect to current value
    if (fn_values(i+1,1) > fn_values(i,1))
        break;
    end
end
%Calculate Lower and Upper bound of the interval in which the minimizer is
%present
a = (2^(count-2))*epsilon;                                   %Lower Bound 
b = (2^(count))*epsilon;                                     %Upper Bound
end