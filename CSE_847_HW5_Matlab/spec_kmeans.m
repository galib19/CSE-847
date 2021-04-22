function [cluster_data, center] = spec_kmeans(data, number_of_clusters)
    %using adjacency matrix and diagonal degree matrix
    Number_of_data = size(data,1);
    matix_adj = squareform(pdist(data));
    degree_matrix = Number_of_data .* eye(Number_of_data);
    %laplacian matrix
    laplacian_matrix = degree_matrix - matix_adj;
    %eigen vectors of the laplacian matrix 
    [eigenvectors,~] = eig(laplacian_matrix);
    [cluster_data, center] = kmeans(eigenvectors(:, 1:number_of_clusters), number_of_clusters);