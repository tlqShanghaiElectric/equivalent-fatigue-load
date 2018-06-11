function C = callRainflow( x )
%RAINFLOW Rainflow counts for fatigue analysis
%   C = RAINFLOW(X) computes cycle counts for fatigue analysis of the load
%   time history, X, according to the ASTM E 1049 standard. The matrix C
%   contains cycle information in its columns, in this order: counts,
%   ranges.

x = x(:);

% Find extrema.
idx = findExtrema(x);

% Perform rainflow counting.
CM = countCycles(x(idx));

% Create the output matrix.
C = CM(:,1:2);
end

