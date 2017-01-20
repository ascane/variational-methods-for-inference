setup;
methods = {'gibbs', 'mf', 'lbp'};
method = 'gibbs';
sz = 250;
mu = 0;
sigma = 1;
percent = 0.5;
for sigma = [-1, -0.7, -0.3, 0, 0.3, 0.7, 1]
    if strcmp(method, 'gibbs')
        X = Gibbs(sz, mu, sigma, percent);
    elseif strcmp(method, 'mf')
        [X, A] = mean_field(sz, mu, sigma, percent);
    else
        X = LBP(50, 0.3, 0.5, 1);
    end
    figure
    colormap(1 - gray);
    imagesc(X)
    filename = ['figs/' method '-' num2str(sz) '-' num2str(mu) '-' num2str(sigma)];
    export_fig(filename, '-pdf');
end
% log-partition function
%h = semilogy(A)
%set(h, 'linewidth', 2);