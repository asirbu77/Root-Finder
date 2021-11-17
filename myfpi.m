% =================================================================
% AUTHOR ....... Aidan Sirbu
% UPDATED ...... Feb 1, 2021
%
% Compute approximate solution to f(x)=0 via fixed point iteration
% 
%
% INPUT
%  g: A function handle for x=g(x) corresponding to f(x)=0
%  tol: Tolerance of the solution
%  maxiter: Maximum number of iterations
%
% OUTPUT
%  xs: Approximation to the fixed point
%  flag: Flag specifying if the solution has been obtained
%        = Number of iterations taken to converge
%        = -1 if the algorithm has not converged in maxiter iterations
% ==================================================================
function [xs, flag]=myfpi(g,x0,tol,maxiter)
    flag = -1;
    xs = x0;
    iter = 0;
    while 1
        iter = iter + 1;
        if iter > maxiter
            break
        end
        xnew = g(x0);
        if xnew-x0<tol
            flag = iter;
            break
        end
        x0=xnew;
    end
    xs=xnew;
end