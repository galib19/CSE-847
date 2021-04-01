function weights = ridge( y, X, lambda )
%getting dimension
dim = size(X,2);
%applying vectorized form of the ridge regression equation 
weights = (X'*X+lambda*eye(dim))\X'*y;
end

