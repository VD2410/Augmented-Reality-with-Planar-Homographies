function [H2to1] = computeH_norm(x1, x2)

%% Compute centroids of the points
centroid1 = mean(x1);
centroid2 = mean(x2);

%% Shift the origin of the points to the centroid

% x1_shift = x1 + centroid1;
% x2_shift = x2 + centroid2;

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
x1_dist = sqrt(x1(:,1).^2 + x1(:,2).^2);
x2_dist = sqrt(x2(:,1).^2 + x2(:,2).^2);

x1_avg_dist = mean(x1_dist);
x2_avg_dist = mean(x2_dist);

x1_norm = sqrt(2)/x1_avg_dist;
x2_norm = sqrt(2)/x2_avg_dist;

%% similarity transform 1
T1 = [x1_norm 0 x1_norm*centroid1(1); 0 x1_norm x1_norm*centroid1(2); 0 0 1];

%% similarity transform 2
T2 = [x2_norm 0 x2_norm*centroid2(1); 0 x2_norm x2_norm*centroid2(2); 0 0 1];

% %% Compute Homography
% x1_new = ([x1(:,1)/x1_norm*centroid1(1),x1(:,2)/x1_norm*centroid1(2), ones(size(x1,1), 1)]);
% x2_new = ([x2(:,1)/x2_norm*centroid2(1),x2(:,2)/x2_norm*centroid2(2), ones(size(x2,1), 1)]);
% % 
% x1_trans = x1_new * T1;
% x2_trans = x2_new * T2;
% % x1_trans = x1_trans';
% % x2_trans = x2_trans';
% 
% H2to1 = computeH(x1_trans,x2_trans);
% %% Denormalization
% H2to1 = T1 * H2to1 * inv(T2); 
% % H2to1 = H2to1./H2to1(3,3);
% 

x1_trans = zeros(size(x1,1), 2);
x2_trans = zeros(size(x2,1), 2);

x1 = [x1, ones(size(x1,1), 1)] * T1;
x2 = [x2, ones(size(x2,1), 1)] * T2;

for i=1:size(x1,1) 
    x1_trans(i,1) = x1(i,1)/x1(i,3);
    x1_trans(i,2) = x1(i,2)/x1(i,3);
       
    x2_trans(i,1) = x2(i,1)/x2(i,3);
    x2_trans(i,2) = x2(i,2)/x2(i,3);
end

H_norm = computeH(x1_trans,x2_trans);

H_norm = H_norm./H_norm(3,3);

H2to1 = (T1 * H_norm * inv(T2));

end
