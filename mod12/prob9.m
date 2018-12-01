%% Inputs
numCycles = 4;
theta = 0:0.1:numCycles * 2*pi;
omega = 1;
phaseNoiseRange = 3; % Eg. if 1, noise will range from -0.5 to 0.5

%% Begin Script
phaseNoise = rand(1, length(theta))*phaseNoiseRange - phaseNoiseRange/2;
pureWav = sin(omega*theta);
phaseNoiseWav = sin(omega*theta + phaseNoise);

plot(theta, pureWav, theta, phaseNoiseWav);
legend('Pure Sine Wave','Sine Wave w/ Phase Noise');