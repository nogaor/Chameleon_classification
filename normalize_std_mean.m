function [data, stats] = normalize_std_mean(data, stats)

if ~exist('stats', 'var')
    stats.m = mean(data, 2);
    stats.s = std(data, 0, 2);
    stats.s(find(stats.s==0)) = 1;
end
[h, w] = size(data);
data = (data - repmat(stats.m, 1, w))./repmat(stats.s, 1, w);
