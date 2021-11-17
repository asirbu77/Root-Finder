function [errorMatrix, a, C]=mynewtonErrorPlot(f,fx,x0,tol,maxiter)
iter = 0;
errorMatrix = [];
ek = [];
ek1 = [];

% Build error matrix
for i=1:maxiter
    iter = iter + 1;
    deltax = -f(x0)./fx(x0);
    xnew = x0 + deltax;
    % errorMatrix is a 1 row matrix (AKA array)
    errorMatrix = [errorMatrix, abs(x0-xnew)];
    if abs(x0-xnew)<tol
        break
    end
    x0=xnew;
end

% Build sub error matrices for e_k and e_k+1
ek = zeros(length(errorMatrix)-1,1);
ek1 = zeros(length(errorMatrix)-1,1);
% For each value in ek, the value at the same index in ek1 will be the
% subsequent value of ek inside the errorMatrix
for i=1:length(errorMatrix)-1
    ek(i,1) = errorMatrix(i);
end
for i=2:length(errorMatrix)
    ek1(i-1,1) = errorMatrix(i);
end

% Solve for alpha and C using least-squares approximation method
y = log(abs(ek1));
% M is matrix of functions with form y = mx + b where:
%   y = l
M = zeros(length(ek),2);
% Least Squares function: r0*x+r1
%   r0 = alpha
%   r1 = log(C)
leastSquaresFunc = @(x)x;
for i=1:length(ek)
    M(i,1) = leastSquaresFunc(log(abs(ek(i))));
    M(i,2) = 1;
end
r = (inv(transpose(M)*M)*(transpose(M)*y));

a = r(1);
C = r(2);

loglog(r(1).*log(abs(ek))+r(2),log(abs(ek1)));
hold on;
scatter(log(abs(ek)),log(abs(ek1)));
grid on;
xlabel('$log_e|e_{k}|$', 'interpreter', 'latex')
ylabel('$log_e|e_{k+1}|$', 'interpreter', 'latex')
