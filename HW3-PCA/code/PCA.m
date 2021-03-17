
minl = min([length(Xt1(1,:)) length(Xt2(1,:)) length(Xt3(1,:))])
t = 1:minl

Xt1 = Xt1(:,1:minl);
Xt2 = Xt2(:,1:minl);
Xt3 = Xt3(:,1:minl);

XY = [Xt1;
    Xt2;Xt3];
[U,S,V] = svd(XY,'econ');
Y = U'*(XY);
st = 1:length(diag(S));


energies = (diag(S).^2)./(sum(diag(S).^2));
figure(1)
subplot(2,1,1)
semilogy(st,energies,'ko','linewidth',2)

set(gca,'Fontsize',10,'Xtick',1:6)
xlabel("number of simgular value")
ylabel("energy (log scale)")
rank3=U(:,1:3)*S(1:3,1:3)*V(:,1:3)';
rank2=U(:,1:2)*S(1:2,1:2)*V(:,1:2)';
rank1=U(:,1)*S(1,1)*V(:,1)';
m = rank1(1,:);
n = rank2(1,:);
p = rank3(1,:);
subplot(2,1,2)
plot(t,m)
hold on 
plot(t,n)
hold on 
plot(t,p)
ylabel("displacement from center(amplitude)")
xlabel("time(frame)")
legend('rank1','rank2','rank3')