function idx = findExtrema(x)
% FINDEXTREMA find local minima and local maxima of vector x.

[~, idx1] = findpeaks(x);
[~, idx2] = findpeaks(-1*x);
idx = vertcat(idx1, idx2);

if (idx1(1) ~= 1 && idx2(1) ~= 1)
    idx(end+1) = 1;
end

len = length(x);
if (idx1(end) ~= len && idx2(end) ~= len)
    idx(end+1) = len;
end

idx = sortrows(idx);

end

