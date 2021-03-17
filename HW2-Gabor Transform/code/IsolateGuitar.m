figure(1)
[y, Fs] = audioread('Floyd.m4a');
trgnr = length(y)/Fs; % record time in seconds
w = 10;

xlabel('Time [sec]'); ylabel('Amplitude');
title('Sweet Child O Mine');
p8 = audioplayer(y,Fs); 

S = y';
S = S(1:w*Fs);
plot((1:length(S))/Fs,S);
L = length(S)/Fs ; n = length(S);
t2 = linspace(0,L,n+1); t = t2(1:n);
w = 10;

a = 500;
tau = 0:0.1:L;
a = 500;
yrecover = zeros(1,length(S));
table = zeros(length(S),length(tau));
Sgt_spec = table;
for j = 1:length(tau)
  g = exp(-a*(t - tau(j)).^2); % Window function
   Sg = g.*S;
   Sgt = fft(Sg);
  table(:,j) = Sgt;
  table(maxarray(j)-20:maxarray(j)+20,j) =zeros(41,1);
  kmax = k(maxarray(j));
  step = max(k)/(length(k)/2);
  I2 = round(maxarray(j) + kmax/step);
  I3 = round(maxarray(j) + 2*kmax/step);
  I4 = round(maxarray(j) + 3*kmax/step);
  table(I2-20:I2+20,j) =zeros(41,1);
  table(I3-20:I3+20,j) =zeros(41,1);
  table(I4-20:I4+20,j) =zeros(41,1);
end


for j = 1:length(k)
    
    if(abs(k(j))>2000||abs(k(j))<300)
        table(j,:) = zeros(1,101);
    end
end


for j = 1:length(tau)
   Sgt_spec(:,j) = fftshift(abs(table(:,j)));
end
Sgt_spec = abs(table);
figure(6)
Sgt_spec = log(Sgt_spec + 1);
pcolor(tau,ks,Sgt_spec)
shading interp
set(gca,'ylim',[300 800],'Fontsize',16)
colormap(hot)
  xlabel('time (t)'), ylabel('frequency (k)')