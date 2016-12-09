% X = Gibbs(50, 0.1);
X = mean_field(50, 0.1);
figure
colormap(1-gray);
imagesc(X)