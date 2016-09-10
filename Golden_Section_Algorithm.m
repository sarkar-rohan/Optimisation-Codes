%This function returns alpha_min, given the interval starting and ending
%point.
% Author: Rohan Sarkar

function alpha=golden_section(a0,b0)

%Objective Function
rho=0.382; %Golden Section Ratio

% Compute Initial set of intermediate points.

a1=a0+rho*(b0-a0);
b1=b0-rho*(b0-a0);

N = 2;% No of iterations

A=zeros(N,1);
B=zeros(N,1);

A(1)=a1;
B(1)=b1;


if (f(B(1)) > f(A(1)))
    x0int=a0;
    x1int=b1;
    B(2)=A(1);
    A(2)=x0int+rho*(x1int-x0int);
else
    x0int=a1;
    x1int=b0;
    A(2)=B(1);
    B(2)=x1int-rho*(x1int-x0int);
end


for i=2:N
    
if (f(B(i)) > f(A(i)))
    x1int=B(i);
    B(i+1)=A(i);
    A(i+1)=x0int+rho*(x1int-x0int);
else
    x0int=A(i);
    A(i+1)=B(i);
    B(i+1)=x1int-rho*(x1int-x0int);
end
end
display(x0int);
display(x1int);
alpha=(x0int+x1int)/2;
end