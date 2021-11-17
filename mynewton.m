function [x, flag]=mynewton(f,fx,x0,tol,maxiter)
%==========================================================================
% Function file: mynewton.m
% Author: Aidan Sirbu, Katie Brown
% Date: Feb 10, 2021
% Purpose: Compute approximate solution to f(x)=0 via Newton's method
%
% Input arguments:
%   f -- A function handle for the function f(x) being solved.
%   fx -- A function handle for the derivative f'(x)
%   x0 -- Initial guess for the solution.
%   tol -- Tolerance wanted in the solution.
%   maxiter -- Maximum number of iterations.
%
% Output arguments:
%   x -- Vector containing the iterates of the Newton's method.
%   flag -- Flag specifying if solution obtained within the tolerance, it
%           should take the values:
%           = The number of iterations taken to converge.
%           = -1 If the algorithm has not converged in maxiter iterations.
%==========================================================================
flag = -1;
iter = 0;
for i=1:maxiter
    iter = iter + 1;
    deltax = -f(x0)./fx(x0);
    xnew = x0 + deltax;
    if abs(x0-xnew)<tol
        flag = iter;
        x0=xnew;
        break
    end
    x0=xnew;
end
x = x0;
end