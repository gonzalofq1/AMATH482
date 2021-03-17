
z = zeros(480,640);
load('cam1_4.mat');
numFrames = size(vidFrames1_4,4);
Xt1 = zeros(2,numFrames);
ps = zeros(2,1)
for q = 1:numFrames
X = vidFrames1_4(:,:,:,q); 
Xg = rgb2gray(X);
z(170:430,220:480) = Xg(170:430,220:480);
Xf = double(z);
bool = Xf > 220;
I = find(bool);
[xpos, ypos] = ind2sub(size(bool),I);
v = [mean(xpos); mean(ypos)];
Xt1(:,q) = v ;    
end


load('cam2_4.mat');
numFrames = size(vidFrames2_4,4);
Xt2 = zeros(2,numFrames);
ps = zeros(2,1)
for q = 1:numFrames
X = vidFrames2_4(:,:,:,q); 
Xg = rgb2gray(X);
z(170:430,220:480) = Xg(170:430,220:480);
Xf = double(z);
bool = Xf > 210;
I = find(bool);
[xpos, ypos] = ind2sub(size(bool),I);
v = [mean(xpos); mean(ypos)];
Xt2(:,q) = v ;    
end


load('cam3_4.mat');
numFrames = size(vidFrames3_4,4);
Xt3 = zeros(2,numFrames);
ps = zeros(2,1)
for q = 1:numFrames
X = vidFrames3_4(:,:,:,q); 
Xg = rgb2gray(X);
z(170:430,220:480) = Xg(170:430,220:480);
Xf = double(z);
bool = Xf > 200;
I = find(bool);
[xpos, ypos] = ind2sub(size(bool),I);
v = [mean(xpos); mean(ypos)];
Xt3(:,q) = v ;    
end