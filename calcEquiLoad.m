function el = calcEquiLoad( x, m )
%CALEQUILAD calculate the equivalent load
%   el = calEquiLoad(x) computes the equivalent load based on the rainflow
%   algorithm for fatigue analysis of the load time history, x and S-N slope
%   m. The output el is the equivalent load of x, whose unit is kNm.

life = 25; %25 years
t = 8766; % hours per year
f = 1e7/(life*t*3600);
T = 600; % cycle time

C = callRainflow(x);
el = (sum(C(:, 1)'* C(:, 2).^m)/(T*f))^(1/m)/1000;

end

