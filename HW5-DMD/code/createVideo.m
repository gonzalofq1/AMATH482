movieback = zeros(540,960,iter);
for i=1:iter-1
qq = reshape(dmd(:,i),540,960);
movieback(:,:,i) = qq;
end
% 
moviefront = zeros(540,960,iter);
for i=1:iter-1
qq = reshape(forg(:,i),540,960);
moviefront(:,:,i) = qq;
end

VidObj2 = VideoWriter('movie1.avi', 'Uncompressed AVI'); %set your file name and video compression
VidObj2.FrameRate = 30; %set your frame rate
open(VidObj2);
for f = 1:size(movieback, 3)  %T is your "100x150x75" matrix
    writeVideo(VidObj2,mat2gray(movieback(:,:,f)));
end
close(VidObj2);

VidObj3 = VideoWriter('movie2.avi', 'Uncompressed AVI'); %set your file name and video compression
VidObj3.FrameRate = 30; %set your frame rate
open(VidObj3);
for f = 1:size(moviefront, 3)  %T is your "100x150x75" matrix
    writeVideo(VidObj3,mat2gray(moviefront(:,:,f)));
end
close(VidObj3);