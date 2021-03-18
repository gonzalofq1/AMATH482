
X1 = data(:,1:end-1); X2 = data(:,2:end);
[U,Sigma,V] = svd(X1,'econ');
S = U'*X2*V*diag(1./diag(Sigma));

[eV, D] = eig(S); % compute eigenvalues + eigenvectors
mu = diag(D); % extract eigenvalue
tfinal = vidObj.Duration;
dt =tfinal/size(data,2);
omega = log(mu)/dt;
[C,D] = min(abs(omega));
omega = omega(D); Phi = U*eV(:,D); t =0:dt:tfinal; y0 = Phi\X1(:,1);


u_modes = zeros(length(y0),length(t));
for iter = 1:length(t)
   u_modes(:,iter) = y0.*exp(omega*t(iter)); 
end
u_dmd = Phi*u_modes;

dmd = u_dmd(:,1:end-1);
forg = data-dmd;
forg = real(forg);
dmd = real(dmd);