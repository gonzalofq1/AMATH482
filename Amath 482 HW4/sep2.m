
l = zeros(2,45)
l2 = zeros(2,45)
f = 15;
q = 0;
data1test = zeros(1,1);
data2test = zeros(1,1);

    for j=0:9
    for i=j:9
    if(j~=i)
    q = q+1;
    l2(:,q) = [i;j];
  
    result = classifygen(j,i,f,labels,data);
    U = result.u;
    w = result.w;
    s1 = size(test.("t"+string(j)),2);
    s2 = size(test.("t"+string(i)),2);
    testm = [test.("t"+string(j)),test.("t"+string(i))];
    av =  mean(testm,1);
 for x=1:size(testm,2)
     testm(:,x) = testm(:,x)-av(x);
 end
    testp = U(:,1:f)'*testm;
    testw = w'*testp;
    alt = result.alt;
    if(alt==false)
        res = testw > result.threshold;
    else
         res = testw < result.threshold;
    end
    correct = [logical(zeros(1,s1)), logical(ones(1,s2))];
    error = (res==correct);
    error = double(error);
    error = (size(error,2) - sum(error))/size(error,2);
    l(1,q) = error;
    l(2,q) = result.with;
    
    
    end
    end
end