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
end