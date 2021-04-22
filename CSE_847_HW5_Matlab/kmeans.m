function [cluster_data, center] = kmeans(data, number_of_clusters)

    Number_of_data = size(data,1);  
    % center intialization
    random_permutation = randperm(Number_of_data);
    center = data(random_permutation(1:number_of_clusters), :);
    updated_center = zeros(size(center));
    %looping until the center update goes under a threshold
    while mean(abs(center - updated_center)) >= 1e-5
        cluster_data = zeros(Number_of_data, 1);
        for index = 1 : Number_of_data
            distances = zeros(1, number_of_clusters);
            %looping through the clusters and measuring distances from the
            %center
            for center_index = 1:number_of_clusters
                temporary_center = center(center_index, :);
                % Saving all distances from the point to all the centers
                distances(center_index) = sum(abs(data(index,:) - temporary_center).^2);
            end
            %getting the index of the least distant center
            [~, idx] = min(distances);
            cluster_data(index) = idx;
        end
        
      
       % getting indices of point and adjusting 
       points = zeros(number_of_clusters, size(data, 2));
       n_clusters = zeros(number_of_clusters, 1);
       updated_center = zeros(size(center));
       
       for index = 1:Number_of_data
           c_index = cluster_data(index);
           points(c_index, :) = points(c_index, :) + data(index, :);
           n_clusters(c_index) = n_clusters(c_index) + 1;
       end
        % setting the updated center
       for center_index=1:number_of_clusters
          updated_center(center_index, :) = points(center_index, :) / n_clusters(center_index);
       end
       center = updated_center;
    end
end