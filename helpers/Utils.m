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
    end
end