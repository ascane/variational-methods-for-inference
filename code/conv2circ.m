function [C] = conv2circ(A)
    kernel = [0,1,0;1,0,1;0,1,0];
    % padding
    xLayer = 1;
    A_x = padarray(A,[xLayer xLayer],'circular');
    C = conv2(A_x, kernel, 'same');
    C = C(xLayer+1:end-xLayer, xLayer+1:end-xLayer);
end