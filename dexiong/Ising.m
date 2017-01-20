% X = Gibbs(50, 0.1);
rng(0);
% X = Gibbs(100, 1, 0.5);
X = mean_field(200, 1, 0.5);
% [X,A] = LBP(200, 1, 0.5, 0.8);
% [X,A] = LBP_iterative(50, 1, 0.5, 0.8);
figure
colormap(1-gray);
imagesc(X)