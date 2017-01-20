% X = Gibbs(50, 0.1);
rng(0);
% X = Gibbs(50, 1, 0.5);
% X = mean_field(50, 1, 0.5);
X = LBP(50, 1, 0.5, 0.6);
figure
colormap(1-gray);
imagesc(X)