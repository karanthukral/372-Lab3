clear all
close all

addpath('images')
addpath('helpers')
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

dataSet = f2;
testDataSet = f2t;

means = [];
tMeans = [];
sigmas = [];
tSigmas = [];
pts = [];
tPts = [];

for i = 1 : 10
    data = [];
    testData = [];
    for j = i * 16 - 15 : i * 16
        if (dataSet(3, j) == i)
            data = [data; dataSet(1, j) dataSet(2, j)];
            testData = [testData; testDataSet(1, j) testDataSet(2, j)];
        end
    end
    
    [mu, sigma] = Utils.learnData(data);
    [tMu, tSigma] = Utils.learnData(testData);
    
    means = [means; mu];
	tMeans = [tMeans; tMu];
	sigmas = [sigmas; sigma];
	tSigmas = [tSigmas; tSigma];
	pts = [pts; data];
	tPts = [tPts; testData];
end

boundary = zeros(1, 160);
testBoundary = zeros(1, 160);

for a = 1 : 160
    boundary(1,a) = Utils.MICDClassifier([testDataSet(1, a), testDataSet(2, a)], means, sigmas);
end

[C,order] = confusionmat(testDataSet(3, :), boundary(1, :));