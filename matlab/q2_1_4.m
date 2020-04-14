%Q2.1.4
close all;

cv_cover = imread('../data/cv_cover.jpg');
cv_desk = imread('../data/cv_desk.png');


[locs1, locs2] = matchPics(cv_cover, cv_desk);

[ H2to1 ] = computeH( locs1, locs2 );

[ H2to1_norm ] = computeH_norm( locs1, locs2 );

[bestH2to1, inliers] = computeH_ransac(locs1, locs2);


ins1 = zeros(size(locs1,1),2);
ins2 = zeros(size(locs2,1),2);
for i=1:length(inliers)

    if inliers(i) == 1
        ins1(i,:) = locs1(i,:);
        ins2(i,:) = locs2(i,:);
    end
end

ins1 = ins1(any(ins1,2),:);
ins2 = ins2(any(ins2,2),:);

figure;
showMatchedFeatures(cv_cover, cv_desk, ins1, ins2, 'montage');
title('Showing all Inliers');



figure;
showMatchedFeatures(cv_cover, cv_desk, locs1, locs2, 'montage');
title('Showing all matches');



locs2 = [locs1, ones(size(locs1,1), 1)] * H2to1;


for i=1:size(locs1,1)
    locs2(i,1) = locs2(i,1)/locs2(i,3);
    locs2(i,2) = locs2(i,2)/locs2(i,3);    
end
figure;
showMatchedFeatures(cv_cover, cv_desk, locs1, locs2(:,1:2), 'montage')


locs2 = [locs1, ones(size(locs1,1), 1)] * H2to1_norm;
for i=1:size(locs1,1)
    locs2(i,1) = locs2(i,1)/locs2(i,3);
    locs2(i,2) = locs2(i,2)/locs2(i,3);    
end
figure;
showMatchedFeatures(cv_cover, cv_desk, locs1, locs2(:,1:2), 'montage')


locs2 = [locs1, ones(size(locs1,1), 1)] * bestH2to1;
for i=1:size(locs1,1)
    locs2(i,1) = locs2(i,1)/locs2(i,3);
    locs2(i,2) = locs2(i,2)/locs2(i,3);    
end
figure;
showMatchedFeatures(cv_cover, cv_desk, locs1, locs2(:,1:2), 'montage')




