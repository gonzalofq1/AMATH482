clc; clear all;
figure(1)
[y, Fs] = audioread('Floyd.m4a');
trgnr = length(y)/Fs; % record time in seconds
plot((1:length(y))/Fs,y);
xlabel('Time [sec]'); ylabel('Amplitude');
title('Sweet Child O Mine');
p8 = audioplayer(y,Fs);
S = y';
w = 10;
S = S(2*w*Fs:3*w*Fs-1);
%% Creating a spectrogram
L = length(S)/Fs ; n = length(S);
t2 = linspace(0,L,n+1); t = t2(1:n);
a = 500;
tau = 0:0.1:L;
k = (1/L)*[0:n/2-1 -n/2:-1];
ks = fftshift(k);
Sgt_spec = zeros(length(ks),length(tau));
for j = 1:length(tau)
    g = exp(-a*(t - tau(j)).^2); % Window function
    Sg = g.*S;
    Sgt = fft(Sg);
    [C,I] = max(abs(Sgt(1:1800)));
    maxk = abs(k(I));
    n = 0.2;
    filter = exp(-n*(abs(k) - k(I)).^2);
    Sgtf = Sgt.*filter;
    
    l = Sgtf; % We don't want to scale it
  
    Sgt_spec(:,j) = fftshift(abs(l));
end

figure(6)
Sgt_spec = log(Sgt_spec + 1);
pcolor(tau+20,ks,Sgt_spec)
shading interp
set(gca,'ylim',[0 300],'Fontsize',16)
colormap(hot)
xlabel('time (t)'), ylabel('frequency (f)')