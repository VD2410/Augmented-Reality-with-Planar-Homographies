function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
% disp((size(I1,3) > 1))
if size(I1, 3) > 1
  I1_gray = rgb2gray(I1);
  else
    I1_gray = I1;

end


if size(I2, 3) > 1
  I2_gray = rgb2gray(I2);
  else
    I2_gray = I2;

end



% I1_grey = (size(I1,3)>1 * rgb2gray(I1)) + (size(I1,3)<=1)*(I1);
%  
% I2_grey = (size(I2,3)>1)*(rgb2gray(I2)) + (size(I2,3)<=1)*(I2);
% 
% imshow(I1_grey);figure
%  
% imshow(I2_grey)

% % 
% detectBRISKFeatures       Detect BRISK features and return BRISKPoints object
% detectFASTFeatures        Detect corners using FAST algorithm and return cornerPoints object
% detectHarrisFeatures      Detect corners using Harris–Stephens algorithm and return cornerPoints object
% detectMinEigenFeatures	Detect corners using minimum eigenvalue algorithm and return cornerPoints object
% detectMSERFeatures        Detect MSER features and return MSERRegions object
% detectORBFeatures         Detect and store ORB keypoints
% detectSURFFeatures        Detect SURF features and return SURFPoints object
% detectKAZEFeatures        Detect KAZE features
% %
%% Detect features in both images
% 
Features1 = detectFASTFeatures(I1_gray);

Features2 = detectFASTFeatures(I2_gray);
% 
% Features1 = detectSURFFeatures(I1_gray);
% Features2 = detectSURFFeatures(I2_gray);



%% Obtain descriptors for the computed feature locations

% [disc_1,point_1]=extractFeatures(I1_gray,Features1);
% [disc_2,point_2]=extractFeatures(I2_gray,Features2);

% disp(Features1.selectStrongest(50).Location);

% imshow(I1); hold on;
% plot(Features1.selectStrongest(50));



[disc_1,point_1]=computeBrief(I1,Features1.Location);
[disc_2,point_2]=computeBrief(I2_gray,Features2.Location);

% [desc, locs] = computeBrief(img, locs_in)

%% Match features using the descriptors'

indexPairs = matchFeatures(disc_1,disc_2, 'MatchThreshold', 10, 'MaxRatio', 0.8);

locs1 = point_1(indexPairs(:,1),:);
locs2 = point_2(indexPairs(:,2),:);


end

