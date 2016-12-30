% compute the sum of the neighours of i
function [s] = neighbours(X, n, i)
    s = 0;
    if i(1)+1 <= n
        s = s+X(i(1)+1, i(2));
    end
    if i(1)-1>= 1
        s = s+X(i(1)-1, i(2));
    end 

    if i(2)+1 <= n
        s = s+X(i(1), i(2)+1);
    end
    if i(2)-1>= 1
        s = s+X(i(1), i(2)-1);
    end 
end