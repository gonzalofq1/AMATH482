% % % SVM classifier with training data, labels and test set
% tott = 15
% 
% s1 = size(train.t4,2);
% s2 = size(train.t9,2);
% data = [train.t4,train.t9];
% [U,S,V] = svd(data);
% v = S(1:tott,1:tott)*V(:,1:tott)';
% n = max(v(:));
% v = v/n;
% 
% Mdl = fitcsvm(v',[zeros(1,s1),ones(1,s2)]');
%   testdata = [test.t4,test.t9];
%  [U,S,V] = svd(testdata,'econ');
% v = S(1:tott,1:tott)*V(:,1:tott)';
% v = v/n;
% errortrain = resubLoss(Mdl)
%   testlabels = predict(Mdl,v');
%  correct = [zeros(1,size(test.t4,2)),ones(1,size(test.t9,2))]
%  error = (logical(testlabels')==logical(correct));
%   error = double(error);
% errortest = (size(error,2) - sum(error))/size(error,2)*100;
% 
% % %

% classify all numbers 
tott = 15;
[U,S,V] = svd(data,'econ');
v = S(1:tott,1:tott)*V(:,1:tott)';
n = max(v(:));
v = v/n;

Mdl = fitcecoc(v',labels)
error = resubLoss(Mdl)

[U,S,V] = svd(datatest,'econ');
v = S(1:tott,1:tott)*V(:,1:tott)';
v = v/n;

error = resubLoss(Mdl)
[S,V,D] = svd(data,'econ')
testlabels = predict(Mdl,v')
C = confusionmat(testlabels,labels2); 
confusionchart(C,{'0','1','2','3','4','5','6','7','8','9'})
cm.Title = 'Confusion matrix of SVM of MNIST dataset';