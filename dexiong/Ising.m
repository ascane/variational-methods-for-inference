setup;
methods = {'gibbs', 'mf', 'lbp'};
method = 'mf';
sz = 50;
mu = 0;
sigma = 1;
percent = 0.5;
for sigma = [-1,-0.5, 0, 0.5, 1, 1.5, 2]
    if strcmp(method, 'gibbs')
        X = Gibbs(sz, sigma, percent);
    elseif strcmp(method, 'mf')
        [X, A] = mean_field(sz, sigma, percent);
    else
        [X, A] = LBP(sz, sigma, percent, 0.8);
    end
    figure
    colormap(1 - gray);
    imagesc(X)
    filename = ['figs/' method '-' num2str(sz) '-' num2str(sigma)];
    export_fig(filename, '-pdf');
end
% log-partition function
method = 'mf';
sz = 50;
[X, A] = mean_field(sz, sigma, percent);
%h = semilogy(A)
%set(h, 'linewidth', 2);