function [s] = neighbours(X, n, i)
% compute the sum of the neighours of i
s = 0;
if i(1)+1 <= n
    s = s+X(i(1)+1, i(2));
else
    s = s+X(1, i(2));
end
if i(1)-1>= 1
    s = s+X(i(1)-1, i(2));
else
    s = s+X(n, i(2));
end 

if i(2)+1 <= n
    s = s+X(i(1), i(2)+1);
else
    s = s+X(i(1), 1);
end
if i(2)-1>= 1
    s = s+X(i(1), i(2)-1);
else
    s = s+X(i(1), n);
end 
end