clear all;
vidObj = VideoReader('ski_drop_low.mp4');
data = zeros(540*960,379);
i = 1;
while hasFrame(vidObj)
    vidFrame = readFrame(vidObj);
    col = rgb2gray(im2double(vidFrame));
    col = col(:);
    data(:,i) = col;
    i = i+1;
end
d = length(data,2);
Idx = zeros(d,1);
Idx(1) = 1;
i = 2;
threshold = 260;
for j = 2:d-1
    if(sum(abs(data(:,j)-data(:,j+1)))>threshold)
        Idx(i) = j;
        i = i+1;
        
    end
end
Idx = Idx(1:i-1,1);
data = data(:,Idx);