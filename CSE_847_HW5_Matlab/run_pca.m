function [e, s] = run_pca(X)
[~, N] = size(X);
m = mean(X, 2);
X = X - repmat(m, 1, N);
[e, s, ~] = svd(X,'econ');
end