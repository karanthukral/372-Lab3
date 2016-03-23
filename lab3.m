clear all
close all

load feat.mat

cloth = readim('cloth.im');
cork = readim('cork.im');
cotton = readim('cotton.im');
face = readim('face.im');
grass = readim('grass.im');
paper = readim('paper.im');
pigskin = readim('pigskin.im');
raiffa = readim('raiffa.im');
stone = readim('stone.im');
straw = readim('straw.im');
wood = readim('wood.im');
wool = readim('wool.im');

dataSet = f8;
testDataSet = f8t;
data = [];
testData = [];
means = [];
testMeans = [];
sigmas = [];
testSigmas = [];
points = [];
testPoints = [];

for i = 1:10
    for j = i * 16 - 15 : i * 16;
        if (dataSet(3, j) == i)
            data = [data; dataSet(1, j) dataSet(2, j)];
            testData = [testData; testDataSet(1, j) testDataSet(2, j)];
        end
    end
[mu, sigma] = Utils.learnData(data);
[testMu, testSigma] = Utils.learnData(testData);
means = [means; mu];
testMeans = [testMeans; testMu];
sigmas = [sigmas; sigma];
testSigmas = [testSigmas; testSigma];
points = [points; data];
testPoints = [testPoints; testData];
end

testdata=testDataSet(1:2,:);
truth=dataSet(3,:);
index = 0;

for i=1:160
    d=Inf;
    for j=0:9
        mean = [means(j+1, 1) means(j+1, 2)];
        tl = sigmas(j+1+index,1);
        tr = sigmas(j+1+index,2);
        bl = sigmas(j+1+index+1, 1);
        br = sigmas(j+1+index+1, 2);
        covar = [tl tr; bl br];
        index = index + 1;
        x=testdata(:,i);
        dist = (x-mean') * inv(covar) * (x-mean')';
        if dist < d
            c(i)=j+1;
            d=dist;
        end
    end
    conf(truth(i),c(i))=conf(truth(i),c(i))+1;
end
    %calculate error probabilities
    img=zeros(10,1);
    for i=1:10
        img(i)=(sum(conf(i,:))-conf(i,i))/sum(conf(i,:))*100;
    end
    img
    nt=sum(diag(conf));
    ne=sum(sum(conf))-sum(diag(conf));
    PE=ne/(nt+ne)*100;

% boundary = zeros(1, 160);
% testBoundary = zeros(1, 160);
% 
% for a = 1 : 160
%     boundary(1,a) = Utils.paraClassifier([testDataSet(1, a), testDataSet(2, a)], means, sigmas);
% end
% 
% [C,order] = confusionmat(testDataSet(3, :), boundary(1, :));
% 
% error = 0;
% for i = 1 : 10
%     for j = 1 : 10
%         if (i ~= j)
%             error = error + C(i, j);
%         end
%     end
% end
%  
% error = error / 160;
