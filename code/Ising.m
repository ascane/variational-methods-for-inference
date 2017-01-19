%X = Gibbs(256, 0, 0.1);
[X, A] = mean_field(256, 0, 0.1);
% X = LBP(50, 0.3, 0.5, 1);
figure
colormap(1 - gray);
imagesc(X)
