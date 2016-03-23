classdef Utils
    methods (Static)
        function [mu, sigma] = learnData(data)
            [N, ~] = size(data);
            mu = sum(data)/N;
            sigma = zeros(2,2);
            for i = 1:N
                sigma = sigma + (data(i,:).'*data(i,:));
            end
            sigma = (1/N) * sigma - (mu.'*mu);
        end
        
        function class = MICD(point, means, variances)
            class = -1;
            numMeans = length(means(:, end));
            distances = [];
            index = 0;
            for i=1:length(numMeans)
                mean = [means(i, 1) means(i, 2)];
                tl = variances(i+index,1);
                tr = variances(i+index,2);
                bl = variances(i+index+1, 1);
                br = variances(i+index+1, 2);
                covar = [tl tr; bl br];
                index = index + 1;
               
                dist = (point-mean) * inv(covar) * (point-mean)';
                distances = [distances dist];
            end
            [~, class] = min(distances);
        end

        
        
        
        function class = paraClassifier(point, means, variances)
            class = -1;
            numMeans = length(means(:, end));
            distance = zeros(1, numMeans);
            mu = [];
            sigma = [];
            index = 0;
            for i=1:numMeans
                tl = variances(i+index,1);
                tr = variances(i+index,2);
                bl = variances(i+index+1, 1);
                br = variances(i+index+1, 2);
                sigma{i} = [tl tr ; bl br];
                mu{i} = [means(i, 1) means(i, 2)];
                index = index + 1;
                
                aMu = cell2mat(mu(i));
                aSigma = cell2mat(sigma(i));
                aGauss = (1/(sqrt(2*pi)^2*sqrt(det(aSigma))))*exp(-0.5*(point - aMu)*inv(aSigma)*(point-aMu)');
                distance(1, i) = aGauss;
                
            end
            
            [~,class] = max(distance);
        end
    end
end