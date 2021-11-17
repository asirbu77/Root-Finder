function [subIntervals, rootList] = myIntervalSolve(f,fx,a,b,interLimit,tol,maxiter)
subIntervals=[];

% Check if interval is smaller than limit
if (b-a)<interLimit
    subIntervals=[a,b];
    return
end

% Divide interval into 2
c=(b+a)/2;

% Call function recursively to build subInterval array
[subTemp1]=myIntervalSolve(f,fx,a,c,interLimit,tol,maxiter);
subIntervals=[subIntervals, subTemp1];
[subTemp2]=myIntervalSolve(f,fx,c,b,interLimit,tol,maxiter);
subIntervals=[subIntervals, subTemp2];

% Declare rootList output as empty before for loop to account for recursive
% calls evaluating in every instant
rootList=[];
for i=1:2:length(subIntervals)
    [newtOut,flag] = mynewton2(f,fx,subIntervals(i),subIntervals(i+1),tol,maxiter);
    % Make sure the root falls within the interval and account for case
    % where one interval ends on a root and the next one starts on that
    % same root
    if (flag~=-2) && (subIntervals(i)~=newtOut)
        rootList = [rootList, newtOut];
    end
end