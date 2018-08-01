% Constants
% HDES places the vehicles evenly on the road
VLENGTH = 5; % m (vehicle length)
R = 70;
RLENGTH = R*2*pi; % m (road length)
VMAX = 5; % m/s (70 mph)
NUM_VEHICLES = 3;
HDES = (RLENGTH - NUM_VEHICLES*VLENGTH)/NUM_VEHICLES;

% System parameters
A = [
 0, 1, 0,  0, 0, -1;
 0, 0, 0,  0, 0,  0;
 0, 0, 0, -1, 0,  1;
 0, 0, 0,  0, 0,  0;
-1, 0, 1,  0, 0,  0;
 0, 0, 0,  0, 0,  0
];

B = [
0, 0, 0;
1, 0, 0;
0, 0, 0;
0, 1, 0;
0, 0, 0;
0, 0, 1
];