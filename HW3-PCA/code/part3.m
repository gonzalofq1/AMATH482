load('cam1_2.mat')
load('cam2_2.mat')
load('cam3_2.mat')


numFrames = size(vidFrames3_2,4);
Xt3 = zeros(2,numFrames);

X = vidFrames3_2(:,:,:,1);
Xg = rgb2gray(X);
imshow(Xg);
[x3,y3] = ginput(1);
Xt3(1,1) = y3;
Xt3(2,1) = x3;


for j = 2:numFrames
    x = Xt3(1,j-1);
    y = Xt3(2,j-1);
    X = vidFrames3_2(:,:,:,j);
    Xg = rgb2gray(X);
    Xg1 = Xg;
   check = Xg(round(x-20,0):round(x+20,0),round(y-20,0):round(y+20,0));
    [C,I] = max(check(:));
    [row,col] = ind2sub(size(check),I);
 
    Xt3(1,j) = x+row -21;
    Xt3(2,j) = y + col-21;
    
end


numFrames = size(vidFrames2_2,4);
Xt2 = zeros(2,numFrames);

X = vidFrames2_2(:,:,:,1);
Xg = rgb2gray(X);
imshow(Xg);
[x2,y2] = ginput(1);
Xt2(1,1) = y2;
Xt2(2,1) = x2;


for j = 2:numFrames
    x = Xt2(1,j-1);
    y = Xt2(2,j-1);
    X = vidFrames2_2(:,:,:,j);
    Xg = rgb2gray(X);
    Xg1 = Xg;
   check = Xg(round(x-20,0):round(x+20,0),round(y-20,0):round(y+20,0));
    [C,I] =max(check(:));
    [row,col] = ind2sub(size(check),I);
 
    Xt2(1,j) = x+row -21;
    Xt2(2,j) = y + col-21;
    
end

numFrames = size(vidFrames1_2,4);
Xt1 = zeros(2,numFrames);

X = vidFrames1_2(:,:,:,1);
Xg = rgb2gray(X);
imshow(Xg);
[xstart,ystart] = ginput(1);
Xt1(1,1) = ystart;
Xt1(2,1) = xstart;


for j = 2:numFrames

    x = Xt1(1,j-1);
    y = Xt1(2,j-1);
    X = vidFrames1_2(:,:,:,j);
    Xg = rgb2gray(X);
   check = Xg(round(x-20,0):round(x+20,0),round(y-20,0):round(y+20,0));
    [C,I] =max(check(:));
    [row,col] = ind2sub(size(check),I);
 
    Xt1(1,j) = x+row -21;
    Xt1(2,j) = y + col-21;
    
end