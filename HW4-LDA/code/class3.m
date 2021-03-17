number1 = 5
number2 = 1
number3 = 3
f =15;
result = classifygen3(number1,number2,number3,f,labels,data);
    U = result.u;
    w = result.w;
    de0 = size(test.("t"+string(number1)),2);
    de1 = size(test.("t"+string(number2)),2);
    d1 = [test.("t"+string(number1)),test.("t"+string(number2))];
    d2 = test.("t"+string(number3));
    s1 = size(d1,2);
    s2 = size(d2,2);
    testm = [d1,d2];
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
    again = ones(1,s1+s2);
    index = zeros(1,1);
    for i=1:(s1+s2)
        if(res(i)==false)
            again(i)=0;
            index = [index,i];
        end
    end
    
    index = index(2:size(index,2))
    
    datag = [d1,d2];
    datag = datag(:,index);
    
     result = classifygen(number1,number2,f,labels,data);
    U = result.u;
    w = result.w;
    
 
    testm = datag;
    av =  mean(testm,1);
 for x=1:size(testm,2)
     testm(:,x) = testm(:,x)-av(x);
 end
    testp = U(:,1:f)'*testm;
    testw = w'*testp;
    alt = result.alt;
    if(alt==false)
        res2 = testw > result.threshold;
    else
         res2 = testw < result.threshold;
    end
   
    totres = ones(1,s1+s2);
   j = 1;
    for i=index
            if(res2(j)==0)
                totres(i)=-1;
                
            end
  
            if(res2(j)==1)
                totres(i)=0;              
            end
        j = j+1;
    end
    err = 0;
    correct = [-1*ones(1,de0),zeros(1,de1),ones(1,s2)];
    for i=1:size(correct,2)
        if(correct(i)~=totres(i))
            err = err +1;
        end
    end
    toterror = err/size(correct,2)*100;