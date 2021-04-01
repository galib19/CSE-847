load('diabetes.mat');
lambda = [1e-5 1e-4 1e-3 1e-2 1e-1 1 10];

%initializing variables
n_lambda = numel(lambda);
n_train = numel(y_train);
n_test = numel(y_test);
loss_train = zeros(n_lambda,1);
loss_test = zeros(n_lambda,1);
loss_validation = zeros(n_lambda,1);

% Finding training and testing loss using ridge regression 
for i=1:n_lambda
    w = ridge(y_train,x_train,lambda(i));
    %calculating training loss
    loss_train(i) = mean((y_train-x_train*w).^2);
    loss_test(i) = mean((y_test-x_test*w).^2);
end

% 5 fold cross validation
%setting the indices
indices = crossvalind('Kfold', n_train, 5);

%for each lambda performing 5-fold cross validation 
for i=1:n_lambda
    for j=1:5
        %get the training and tesing indices of the fold
        train=find(indices~=j);
        test=find(indices==j);
        %calculating the weights
        w = ridge(y_train(train),x_train(train,:),lambda(i));
        %calculating loss for validation
        loss_validation(i) = loss_validation(i) + sum((y_train(test)-x_train(test,:)*w).^2);
    end
end
%calculating MSE
loss_validation = loss_validation/n_train;

%getting the best lamda's index and printing
[~,best] = min(loss_validation);
fprintf('The best lambda according to training data is: %f\n',lambda(best));

% Plotting all the results 
figure;
hold on;
plot(lambda,loss_train,'-sr');
plot(lambda,loss_test,'-ob');
plot(lambda,loss_validation,'-*m');
plot(lambda(best),loss_validation(best),'-*m','MarkerSize',20)
hold off;
set(gca,'xscale','log');
xlabel('Lambda');
ylabel('MSE');
legend('Training MSE','Testing MSE','5-fold cross validation MSE')
box on;
ax = gca; 
ax.FontSize=10;
ax.TickLength = [0.02 0.02];
%ax.XLim = [1e-5, 15];

