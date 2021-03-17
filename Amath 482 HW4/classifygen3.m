function result = classifygen3(number1,number2,number3,f,labels,data)
data1 = zeros(1,1);
data2 = zeros(1,1);


for i=1:60000
    if(labels(i)==(number1||number2))
        data1 = [data1,i];
    end
    if(labels(i)==number3)
        data2 = [data2,i];
    end
end
nb1 = size(data1,2);
nb2 = size(data2,2);
data1 = data1(2:nb1);
data2 = data2(2:nb2);

numb1data = data(:,data1);
numb2data = data(:,data2);

 tdata = [numb1data,numb2data];
 av =  mean(tdata,1);
 for i=1:size(tdata,2)
     tdata(:,i) = tdata(:,i)-av(i);
 end
 [U,S,V] = svd(tdata,'econ');
 
 numbers = S*V';
 n1 = numbers(1:f,1:nb1-1);
 n2 = numbers(1:f,nb1:nb2+nb1-2);
 
%% Calculate scatter matrices

m1 = mean(n1,2);
m2 = mean(n2,2);

Sw = 0; % within class variances
for k = 1:nb1-1
    Sw = Sw + (n1(:,k) - m1)*(n1(:,k) - m1)';
end
for k = 1:nb2-1
   Sw =  Sw + (n2(:,k) - m2)*(n2(:,k) - m2)';
end

Sb = (m1-m2)*(m1-m2)'; % between class

%% Find the best projection line

[V2, D] = eig(Sb,Sw); % linear disciminant analysis
[lambda, ind] = max(abs(diag(D)));
w = V2(:,ind);
w = w/norm(w,2);

%% Project onto w

v1 = w'*n1;
v2 = w'*n2;

%% Make first value under theshold 

d = size(v1,2);
d2 = size(v2,2);

alt = false;
if mean(v1) > mean(v2)
   alt = true; 
end

if(alt==false)
    sort1 = sort(v1);
    sort2 = sort(v2);
    t1 = length(sort1);
    t2 = 1;
    while sort1(t1) > sort2(t2)
        t1 = t1 - 1;
        t2 = t2 + 1;
    end
else
    sort1 = sort(v2);
    sort2 = sort(v1);
    t1 = length(sort1);
    t2 = 1;
    while sort1(t1) > sort2(t2)
        t1 = t1 - 1;
        t2 = t2 + 1;
    end
end
s = [d,d2];
t = [t1,t2];
[c,I] = max(t);
[c,I2] = min(t);

threshold = (sort1(t1) + sort2(t2))/2;

result =  struct;
result.threshold = threshold;
result.u = U;
result.w = w;
result.alt = alt;
end