load 'USPS.mat';

p = [10 50 100 200];

length_of_p = length(p);
error = zeros(length_of_p,1);
columns = 3;
figure;
hold on;
for i=1:length_of_p
    current_p = p(i);
    mu = mean(A);
    % getting residuals and reconstructed, ignoring residuals
    [eigenvectors, scores] = run_pca(A);
    reconstructed = scores(:,1:current_p) * eigenvectors(:,1:current_p)';
    size(reconstructed)
    reconstructed = bsxfun(@plus, reconstructed', mu);
    % error from original - reconstructed
    % using the frobineus norm
    error(i) = norm((A-reconstructed),'fro');
   
    % reshapping the first two images
    A1 = reshape(reconstructed(1,:), 16, 16);
    A2 = reshape(reconstructed(2,:), 16, 16);
    
    ax = subplot(length_of_p,columns,i*columns-2);
    text(0.8, 0.8, ['p=' num2str(p(i))]);
    set ( ax, 'visible', 'off')
    % plot images
    subplot(length_of_p,columns,i*columns-1);
    imshow(A1');
    subplot(length_of_p,columns,i*columns);
    imshow(A2');
end
hold off;

% plot error
figure;
plot(p, error, 'o-');
xlabel('Number of components');
ylabel('Total reconstruction error');
title("Principal Components Analysis");
saveas(gcf, 'pca.png');
