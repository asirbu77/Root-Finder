function [x, flag]=mynewton2(f,fx,a,b,tol,maxiter)
flag = -1;
iter = 0;
x0 = (a+b)/2;
for i=1:maxiter
    if (x0<a) || (x0>b)
        flag = -2;
        break
    end
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