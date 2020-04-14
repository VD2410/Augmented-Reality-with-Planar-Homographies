function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
% list of matching points.

inlier_max = 0;
inliers = zeros(size(locs1,1),1);
random1 = zeros(10,2);
random2 = zeros(10,2);
for iteration = 1 : 1000
    for i=1:10
        random_index_point = randperm(size(locs1,1),1);
        random1(i,1) = locs1(random_index_point, 1);
        random1(i,2) = locs1(random_index_point, 2);
        random2(i,1) = locs2(random_index_point, 1);
        random2(i,2) = locs2(random_index_point, 2);     
    end
    H2to1 = computeH_norm(random1,random2);
    H_trans_loc = [locs1,ones(size(locs1,1), 1)]*H2to1;
    for i=1:size(locs1,1)
        H_trans_loc(i,1) = H_trans_loc(i,1)/H_trans_loc(i,3);
        H_trans_loc(i,2) = H_trans_loc(i,2)/H_trans_loc(i,3);
    end
    
    distance = sqrt((H_trans_loc(:,1) - locs2(:,1)).^2 + (H_trans_loc(:,2) - locs2(:,2)).^2);
    
    inlier_temp = distance < 1;
    
  
    inlier = nnz(inlier_temp);
 

    if inlier > inlier_max
        inlier_max = inlier;
        inliers = inlier_temp;
        bestH2to1 = H2to1;
    end
end


