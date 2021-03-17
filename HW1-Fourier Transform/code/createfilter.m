%
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