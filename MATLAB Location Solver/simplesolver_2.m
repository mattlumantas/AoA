clf
area = [20 20];
receiver_locations = [-11.441 11.979; 17.935 0.614; -16.698 -11.672];
receiver_azimuths = [-r1t1_raw_az r2t1_raw_az -r3t1_raw_az];
receiver_est_azimuths = [r1t2_ r2t2_ r3t2_];
%receiver_locations = [-1000 -1000; 0 1000; 1000 -1000];
%receiver_azimuths = [45 -90 135];
%receiver_est_azimuths = [0 0 0];
delta_angle = 0;
length = 50;

net_angle = receiver_azimuths + receiver_est_azimuths + [delta_angle/2 ; -delta_angle/2];
receiver_space = zeros(2*size(receiver_locations,1),2);
receiver_space(1:2:end,:) = receiver_locations;
receiver_space(2:2:end,:) = receiver_locations;
net_angle = reshape(net_angle,1,size(net_angle,1)*size(net_angle,2));
dummy = 0:.01:length;

receiver_line = [length*cosd(net_angle); length*sind(net_angle)]';
x_vals = [receiver_space(:,1) receiver_space(:,1)+receiver_line(:,1)];
y_vals = [receiver_space(:,2) receiver_space(:,2)+receiver_line(:,2)];

x_space = zeros(size(x_vals,1),length);
y_space = zeros(size(y_vals,1),length);
for i = 1:size(x_vals,1)
    x_range(i) = x_vals(i,2) - x_vals(i,1);
    y_range(i) = y_vals(i,2) - y_vals(i,1);
    x_space(i,:) = linspace(x_vals(i,1),x_vals(i,2),length);
    y_space(i,:) = linspace(y_vals(i,1),y_vals(i,2),length);
end

coeff = zeros(size(receiver_space,1),2);
est = zeros(size(receiver_space,1),size(dummy,2));
%x_range = zeros(length,1);
for i = 1:size(x_vals,1)
    %x_range = 0:x_vals(i,2)-x_vals(i,1)/length:x_vals(i,2)-x_vals(i,1);
    coeff(i,:) = polyfit(x_vals(i,:),y_vals(i,:),1);
    est(i,:) = coeff(i,1)*dummy+coeff(i,2);
    %plot(x_vals(i,:),y_vals(i,:));
end

hold on
for i = 1:size(x_vals,1)
    plot(x_vals(i,:),y_vals(i,:));
end

xlim([-area(1) area(1)]); ylim([-area(2) area(2)]);

intercepts = zeros(size(x_vals,1),size(x_vals,1),2);
for i = 1:2:size(x_vals,1)
    for l = i+2:size(x_vals,1)
%         [a,index] = min(abs(est(i,:)-est(l,:)));
%         intercepts(i,l,:) = [index est(i,index)];
          %[a,index] = min(sqrt((x_space(i,:)-x_space(l,:)).^2 + (y_space(i,:)-y_space(l,:)).^2));
          D = pdist2([x_space(i,:); y_space(i,:)]',[x_space(l,:); y_space(l,:)]');
          [M,I] = min(D(:));
          [Irow, Icol] = ind2sub(size(D),I);
          intercepts(i,l,:) = [x_space(i,Irow) y_space(i,Irow)];
    end
    for l = i+2:size(x_vals,1)
           D = pdist2([x_space(i+1,:); y_space(i+1,:)]',[x_space(l,:); y_space(l,:)]');
          [M,I] = min(D(:));
          [Irow, Icol] = ind2sub(size(D),I);
          intercepts(i+1,l,:) = [x_space(i+1,Irow) y_space(i+1,Irow)];
    end
end
% xints = nonzeros(intercepts(:,:,1)/(length*100).*x_range')+receiver_space(:,1);
% yints = nonzeros(intercepts(:,:,2)/(length*100).*abs(y_range'))+receiver_space(:,2);
% xints = [];
% yints = [];
% for i=1:size(intercepts(:,:,1),1)
%     xints = [xints; nonzeros(intercepts(i,:,1)) + receiver_space(i,1)];
%     yints = [yints; nonzeros(intercepts(i,:,2)) + receiver_space(i,2)];
% end
xints = nonzeros(intercepts(:,:,1));
yints = nonzeros(intercepts(:,:,2));
point = [mean(xints) mean(yints)];
radius = sqrt(std(xints)^2 + std(yints)^2);
%viscircles(point,radius);
scatter(receiver_locations(:,1),receiver_locations(:,2));
grid

total_area = 4*area(1)*area(2);
search_area = radius^2*pi
percent_to_search = search_area/total_area*100

%[a,index] = min(abs(est(1,:)-est(2,:)-est(3,:)))
%fill(xints,yints,'r')
hold off