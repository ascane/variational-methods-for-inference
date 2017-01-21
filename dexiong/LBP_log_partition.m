function [At] = LBP_log_partition(messages, eta, sigma)

aux = squeeze(prod(messages, 3));
p1 = squeeze(exp(eta).*aux(:,:,2));
p0 = squeeze(exp(-eta)*aux(:,:,1));
p = p1./(p1 + p0);
At = (2*p-1).*eta + neg_xlogx(p)+neg_xlogx(1-p);

% pair-wise information
% left-right
p1_left = p1./squeeze(messages(:,:,3,2));
p1_right = p1 ./squeeze(messages(:,:,1,2));
p0_left = p0./squeeze(messages(:,:,3,1));
p0_right = p0 ./squeeze(messages(:,:,1,1));

a = exp(sigma) * (p1_left .* [p1_right(:, 2:end), p1_right(:, 1)]);
b = exp(sigma) * (p0_left .* [p0_right(:, 2:end), p0_right(:, 1)]);
c = exp(-sigma) * (p1_left .* [p0_right(:, 2:end), p0_right(:, 1)]);
d = exp(-sigma) * (p0_left .* [p1_right(:, 2:end), p1_right(:, 1)]);
s = a+b+c+d;
a = a./s;
b = b./s;
c = c./s;
d = d./s;

xi = p;
xj = [p(:, 2:end), p(:, 1)];

At = At + sigma*(a+b-c-d);
At = At + neg_xlogx(a)+ neg_xlogx(b)+ neg_xlogx(c)+ neg_xlogx(d);
At = At + a*log(xi*xj) + b*log((1-xi)*(1-xj)) + c * log(xi*(1-xj)) + d*log((1-xi)*xj);


% top-bottom
p1_top = p1./squeeze(messages(:,:,4,2));
p1_bottom = p1 ./squeeze(messages(:,:,2,2));
p0_top = p0./squeeze(messages(:,:,4,1));
p0_bottom = p0 ./squeeze(messages(:,:,2,1));

a = exp(sigma) * (p1_top .* [p1_bottom(2:end, :); p1_bottom(1, :)]);
b = exp(sigma) * (p0_top .* [p0_bottom(2:end, :); p0_bottom(1, :)]);
c = exp(-sigma) * (p1_top .* [p0_bottom(2:end, :); p0_bottom(1, :)]);
d = exp(-sigma) * (p0_top .* [p1_bottom(2:end, :); p1_bottom(1, :)]);
s = a+b+c+d;
a = a./s;
b = b./s;
c = c./s;
d = d./s;

xi = p;
xj = [p(2:end, :); p(1, :)];


At = At + sigma*(a+b-c-d);
At = At + neg_xlogx(a)+ neg_xlogx(b)+ neg_xlogx(c)+ neg_xlogx(d);
At = At + a*log(xi*xj) + b*log((1-xi)*(1-xj)) + c * log(xi*(1-xj)) + d*log((1-xi)*xj);

At = sum(sum(At));

end