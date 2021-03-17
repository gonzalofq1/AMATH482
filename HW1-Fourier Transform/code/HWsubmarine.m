-6.91% Clean workspace
 clear all; close all; clc
cd C:\Users\Gonzalo\Documents\'amath 482'\
 load('subdata.mat') %load data matrix
 L = 10; % spatial domain
 n = 64; % Fourier modes
 x2 = linspace(-L,L,n+1); x = x2(1:n); y =x; z = x; %create 3D axis arrays with 64 points
 k = (2*pi/(2*L))*[0:(n/2 - 1) -n/2:-1]; %create frequency array and rescale them to be 2pi periodic 
 ks = fftshift(k); %shift values do display them in order 
 
 %Create 3D matrices for both spatial domain and frequency domain 
 [X,Y,Z] = meshgrid(x,y,z);
 [Kx,Ky,Kz] = meshgrid(ks,ks,ks);
 
 
 %use a for loop and a matrix to sum all the realizations 
 SumUnt = zeros(n,n,n);
 for t = 1:49
     Un(:,:,:) = reshape(subdata(:,t),n,n,n); %reshape input data into 3D matrix form 
     Unt = fftn(Un); %Using Fast Fourier transform in 3D
     SumUnt = SumUnt + Unt;
 end
 
 SumUnt = SumUnt/49; %normalizing the sumation of the realizations in frequency space 
 [C,I] = max(SumUnt(:)); %finding peak frequencies in 3D 
 [I1,I2,I3] = ind2sub(size(SumUnt),I); %match the indexes to subscripts in a 3D matrix 

 % Find peak frequencies 
 MaxKx = k(I1);
 MaxKy = k(I2);
 MaxKz = k(I3);
 
 
%creates Gaussian Filter fuction  
tau = 0.1 %inversely proportional to width of filter
GaussianFilter = createfilter(k,k,k,MaxKx,MaxKy,MaxKz,tau,n);
 

locationXYZ = zeros(3,49)
for t=1:49
Un(:,:,:) = reshape(subdata(:,t),n,n,n);
%use Gaussian filter on the frequency domain of the data 

Unt = fftn(Un); 
Uf = ifftn(Unt.*GaussianFilter); 

[C,I] = max(Uf(:)); %find peak of amplitude in filtered sound 
[I1,I2,I3] = ind2sub(size(Uf),I); %match index to 3D matrix
locationXYZ(1,t) = x(I1);
locationXYZ(2,t) = y(I2);
locationXYZ(3,t) = z(I3);

end 

%Plots the location of the submarine over time 
plot3(locationXYZ(1,:),locationXYZ(2,:),locationXYZ(3,:),'-o','Color','b','MarkerSize',10,'MarkerFaceColor','#D9FFFF')
grid on 
xlabel('X')
ylabel('Y')
zlabel('Z')

%creates and saves the table with the locations of the submarine  
time = 0:0.5:24
T = table(locationXYZ(1,:)',locationXYZ(2,:)',time')
writetable(T,'table.csv','Delimiter',' ') 
type 'table.csv'

%%
%function that creates the a 3D Gaussain fuction, given the frequency
%discretization in 3 coordinates and its corresponding peaks. Also needs a
%tau 


function result = createfilter(kx,ky,kz,MaxKx,MaxKy,MaxKz,tau,n)

filter = rand(n,n,n);
f = @(Kx,Ky,Kz)(exp(-tau*((Kx-MaxKx).^2+(Ky-MaxKy).^2+(Kz-MaxKz).^2)));
for i=1:n
for j =1:n
for l=1:n
filter(i,j,l) = f(kx(i),ky(j),kz(l));
end
end
end
result = filter;

end