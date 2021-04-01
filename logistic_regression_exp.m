% read data
data_file = fullfile('spam_email','data.txt');
labels_file = fullfile('spam_email','labels.txt');

%load data and labels
%adding a column of 1's to the data
data = load(data_file);
data = [data, ones(size(data,1),1)]; 
labels = load(labels_file);

%getting train data
X_train = data(1:2000,:);
y_train = labels(1:2000);

%getting test data 
X_test = data(2001:4601,:);
y_test = labels(2001:4601);

% setting number of rows 
num_of_rows = [200 500 800 1000 1500 2000];
%initializing accuracy as 0's
test_accuracy = zeros(size(num_of_rows));

for i=1:numel(num_of_rows)
    %getting train X and train y data 
    train_X = X_train(1:num_of_rows(i),:);
    train_y = y_train(1:num_of_rows(i),:);
    % training with the logistic train 
    w = logistic_train(train_X, train_y);
    % model evaluation 
    y_predicted = logsig(X_test*w);
    y_predicted(y_predicted>=0.5) = 1;
    y_predicted(y_predicted<0.5) = 0;
    %test accuracy = number of correct predictions / total predictions
    test_accuracy(i) = sum(y_predicted==y_test)/numel(y_test);
end

% plotting 
figure;
plot(num_of_rows, test_accuracy, 's-');
title('Logistic Regression Experiment');
xlabel('Number of rows (n)');
ylabel('Accuracy');
saveas(gcf, 'log_reg_accuracy.png');