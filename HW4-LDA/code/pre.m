clear all
[images, labels] = mnist_parse('train-images.idx3-ubyte','train-labels.idx1-ubyte');

data = zeros(28*28,60000);
for i=1:60000
    im = images(:,:,i);
    im = im(:);
    data(:,i) = im;
end
 av =  mean(data,1);
 for i=1:size(data,2)
     data(:,i) = data(:,i)-av(i);
 end
[images2, labels2] = mnist_parse('t10k-images.idx3-ubyte','t10k-labels.idx1-ubyte');
datatest = zeros(28*28,10000);
for i=1:10000
    im = images2(:,:,i);
    im = im(:);
    datatest(:,i) = im;
end
 av =  mean(datatest,1);
 for i=1:size(datatest,2)
     datatest(:,i) = datatest(:,i)-av(i);
 end
 [U,S,V] = svd(data,'econ');
 d = diag(S);
 t = 1:784;
 dsum = zeros(1,784);
 summ = 0
 for i=1:784
 summ = summ + d(i);
 dsum(i) = summ;
 end
 plot(t,dsum/summ,'o')
 
 
 test = struct;
test.t0 = dividetest(0,datatest,labels2);
test.t1 = dividetest(1,datatest,labels2);
test.t2 = dividetest(2,datatest,labels2);
test.t3 = dividetest(3,datatest,labels2);
test.t4 = dividetest(4,datatest,labels2);
test.t5 = dividetest(5,datatest,labels2);
test.t6 = dividetest(6,datatest,labels2);
test.t7 = dividetest(7,datatest,labels2);
test.t8 = dividetest(8,datatest,labels2);
test.t9 = dividetest(9,datatest,labels2);

train = struct;
train.t0 = dividetest(0,data,labels);
train.t1 = dividetest(1,data,labels);
train.t2 = dividetest(2,data,labels);
train.t3 = dividetest(3,data,labels);
train.t4 = dividetest(4,data,labels);
train.t5 = dividetest(5,data,labels);
train.t6 = dividetest(6,data,labels);
train.t7 = dividetest(7,data,labels);
train.t8 = dividetest(8,data,labels);
train.t9 = dividetest(9,data,labels);



function result=dividetest(num,datatest,labels2)
    data1test = zeros(1,1);
    for m=1:size(datatest,2)
        if(labels2(m)==(num))
            data1test = [data1test,m];
        end
        
    end
    result = datatest(:,data1test(2:size(data1test,2)));
    
end
    

