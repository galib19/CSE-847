function [w] = logistic_train(data, labels, epsilon, maxiter)
% %
%code to train a logistic regression classifier
% %
%INPUTS:
% data = n * (d+1) matrix withn samples and d features, where
% column d+1 is all ones (corresponding to the intercept term)
% labels = n * 1 vector of class labels (taking values 0 or 1)
% epsilon = optional argument specifying the convergence
% criterion - if the change in the absolute difference in
% predictions, from one iteration to the next, averaged across
% input features, is less than epsilon, then halt
% (if unspecified, use a default value of 1e-5)
% maxiter = optional argument that specifies the maximum number of
% iterations to execute (useful when debugging in case your
% code is not converging correctly!)
% (if unspecified can be set to 1000)
% %
%OUTPUT:
% weights = (d+1) * 1 vector of weights where the weights correspond to
% the columns of "data"
%
%getting number of arguments and
%setting default epsilon 
if nargin == 2
    epsilon = 1e-5;
end
%setting default maxiter 
if nargin < 4
    maxiter = 1000;
end
%initialization
w_0 = zeros(size(data, 2), 1);%initial weights
y_0 = logsig(data*w_0);%initial y

%Newton-Raphson Method
i=0; 
for i = 1:maxiter
    
    R = diag(y_0.*(1-y_0));
    delta = 0.01;
    R = R + delta * eye(length(R));
    w_x = data'*R*data; % f(w)
    d_w_x = data'*(y_0-labels); % d(f(w) = f'(w)
    w = w_0-w_x\d_w_x; % w(i+1) = w(i) - f(w)/f'(w)
    y = logsig(data*w);
    % convergence criterion: y_new - y_old < epsilon
    if mean(abs(y-y_0)) < epsilon
        break;
    end
    %updating values
    y_0 = y;
    w_0 = w;
end

end




