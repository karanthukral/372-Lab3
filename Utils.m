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
        
        function class = MICDClassifier(point, means, variances)
            mean = [];
            dist = [];
            variance = [];
            numOfMeans = length(means(:, end));
            count = 0;
            for k=1:numOfMeans
                mean{k} = [means(k, 1), means(k, 2)];
                variance{k} = [variances(k+count,1) variances(k+count+1,2); variances(k+count+1, 1) variances(k+count+1, 2)];
                dist = sqrt((point - cell2mat(mean(k)))*inv(variances(k))*(point - cell2mat(mean(k)))');
                count = count +1;
                if (k ==1)
                    distances = [dist];
                else
                    distances = [distances dist];
                end
            end
            
            [~,class] = min(distances);
        end
    end
end