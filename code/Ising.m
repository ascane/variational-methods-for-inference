% X = Gibbs(50, 0.5);
[X, A] = mean_field(50, 0.3);
% X = LBP(50, 0.3, 0.5, 1);
figure
colormap(1 - gray);
imagesc(X)
