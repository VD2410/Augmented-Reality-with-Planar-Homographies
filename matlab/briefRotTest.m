% Your solution to Q2.1.5 goes here!



%% Read the image and convert to grayscale, if necessary
cv_cover = imread('../data/cv_cover.jpg');


%% Compute the features and descriptors


plot=zeros(36,1);

for i = 0:36
    %% Rotate image
    
    cv_cover_rotated = imrotate(cv_cover, i*10);
    
    %% Compute features and descriptors
    
    [locs1, locs2] = matchPics(cv_cover, cv_cover_rotated);
    
    %% Match features
    
    figure;
    showMatchedFeatures(cv_cover, cv_cover_rotated, locs1, locs2, 'montage');
    title('Showing all matches');
    %% Update histogram
    
    plot(i+1) = length(locs1);
end

%% Display histogram
f=figure;
bar(length(plot),plot)
title('SURF');
xlabel('Angle');
ylabel('Matches');
saveas(f,sprintf('../results/brief.png'));
close(f)