figure(1)
[y, Fs] = audioread('Floyd.m4a');
trgnr = length(y)/Fs; % record time in seconds


p8 = audioplayer(y,Fs); 

S = y';
St = fft(S);
L = length(S)/Fs ; n = length(S);
t2 = linspace(0,L,n+1); t = t2(1:n);
k = (1/L)*[0:n/2-1 -n/2:-1];

for j = 1:length(k)
    
    if(abs(k(j))>300)
        St(j) = 0;
    end
end

S = ifft(St);

p9 = audioplayer(S,Fs); 
 playblocking(p9)