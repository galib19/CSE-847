
%randomly taking 1000 points within the range of 0 to 50
random_data=randi([0,50], 1000, 2);

%assuming number of cluster is 4
number_of_clusters = 4;

%fitting the data with kmeans clustering 
[cluster_data, ~] = kmeans(random_data, number_of_clusters);
%plotting the clusters
figure;
hold on;
%scatter plot
scatter(random_data(:,1),random_data(:,2),[],cluster_data)
title("K-means Clustering (k=4)");
saveas(gcf, 'kmeans.png');

[cluster_data, ~] = spec_kmeans(random_data, number_of_clusters);
figure;
scatter(random_data(:,1),random_data(:,2),[],cluster_data)
title("Spectral Relaxation of K-means(k=4)");
saveas(gcf, 'spectral_kmeans.png');
