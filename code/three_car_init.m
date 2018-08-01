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

% Initial positions
pos3 = RLENGTH;
pos2 = pos3 + 125 - RLENGTH;
pos1 = pos2 + 125;

h1_init = pos3 - pos1;
v1_init = 0;
h2_init = abs(pos2 - pos1);
v2_init = 0;
h3_init = abs(pos3 - pos2);
v3_init = 0;

X0 = [h1_init; v1_init; h2_init;
      v2_init; h3_init; v3_init];
