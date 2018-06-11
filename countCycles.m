function C = countCycles(y)
%COUNTCYCLES Rainflow cycle counts

M = size(y,1);
A = zeros(M,1);
C = zeros(length(y),5,'like',y);

% Data index variables
iY = 1;
iA = 0;
iC = 1;

% Pass through the data. Collect extrema in A and count cycles.
for cnt = 1:M
   % Step 1: Read next peak or valley. If out of data, go to step 6.
  % If there are less than three points, go to Step 1.
  iA = iA+1;
  A(iA) = iY;
  iY = iY + 1;
  % Step 2: Form ranges X and Y using the three most recent peaks and
  % valleys that have not been discarded.
  % Step 3: Compare the absolute values of ranges X and Y
  while iA >= 3 && abs(y(A(iA-1))-y(A(iA-2))) <= abs(y(A(iA))-y(A(iA-1)))
    switch(iA)
      case 1
        % No op;
      case 2
        % No op;
      case 3
        % Step 5: Count range Y as one-half cycle; discard the first point
        % (peak or valley) in range Y; move the starting point to the second
        % point in range Y; and go to Step 2.
        cRange = abs((y(A(iA-1))-y(A(iA-2))));
        cMean = (y(A(iA-1))+y(A(iA-2)))/2; 
        if (cRange > 0)
          C(iC,:) = [0.5 cRange cMean A(iA-2) A(iA-1)];
          iC = iC + 1;
        end
        A(1) = A(2);
        A(2) = A(3);
        iA = 2;
      otherwise
        % Step 4: Count range Y as one cycle; discard the peak and valley of
        % Y; and go to Step 2.
        cRange = abs((y(A(iA-1))-y(A(iA-2))));
        cMean = (y(A(iA-1))+y(A(iA-2)))/2; 
        if (cRange > 0)
          C(iC,:) = [1.0 cRange cMean A(iA-2) A(iA-1)];
          iC = iC + 1;
        end
        A(iA-2)=A(iA);
        iA=iA-2;
    end
  end
end
% Step 6: Count each range that has not been previously counted as one-half
% cycle.
for cnt = 1:iA-1
  cRange = abs(y(A(cnt))-y(A(cnt+1)));
  cMean = (y(A(cnt))+y(A(cnt+1)))/2;
  if (cRange > 0)
    C(iC,:) = [0.5 cRange cMean A(cnt) A(cnt+1)];
    iC = iC + 1;
  end
end

C = C(1:iC-1,:);