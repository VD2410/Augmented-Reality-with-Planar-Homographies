% Q3.3.1

cv_cover = imread('../data/cv_cover.jpg');

book = loadVid('../data/book.mov');
source = loadVid('../data/ar_source.mov');

result = VideoWriter('../data/ar.avi');
open(result);


for i=1:length(book)
    
   book_frame = book(i).cdata;
   if i <= length(source)
       source_frame = source(i).cdata;
   else
       source_frame = source(i - length(source)).cdata;
   end
   sourse_resized = source_frame(50:size(source_frame,1)-50, 213:426, :);
   
   [locs1, locs2] = matchPics(cv_cover, book_frame);
   [bestH2to1,~] = computeH_ransac(locs1, locs2);
      
   scaled_source = imresize(sourse_resized, size(cv_cover));
   
   result_frame = compositeH(bestH2to1, scaled_source, book_frame);
   
   imwrite(result_frame,'../data/AR_images/'+string(i)+'frame.jpg')
      
   writeVideo(result,result_frame);

end

close(result);

