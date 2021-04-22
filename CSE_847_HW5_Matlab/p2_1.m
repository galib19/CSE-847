data=[0, 0; -1, 2; -3, 6; 1, -2; 3, -6];

figure;
plot(data(:,1),data(:,2), 'b.','markersize', 10);
xlabel('X');
ylabel('Y');
xlim([-10 10]);
ylim([-10 10]);
saveas(gcf, 'p2_1.png');


