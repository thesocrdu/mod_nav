%% User defined inputs
% Initial inputs to satelite locations
el1 = 22.3; % Elevation in deg
phis1 = -27.5; % Satallite longitude in degrees

el2 = 30.1; % Elevation in deg
phis2 = -115; % Satallite longitude in degrees

% Initial guess for location on Earth
thetae0 = 40; % Person's latitude
phie0 = -76;   % Person's longitude

%% Algorithm starts here
% Iterative input
X = [thetae0; phie0];
DeltaX = [Inf; Inf];
r_ratio = 6.371e6 / 42240000;

%% Iterative portion starts here
loop = 0;
dx_arr = ones(1000,1);
figure; hold on;
while (norm(DeltaX) > 1e-5 && ~isnan(norm(DeltaX)))

    % Equations for our two circles are:
    F1 = (cosd(X(1)) * cosd(phis1-X(2)) - r_ratio) /...
        cos(asin(cosd(X(1)) * cosd(phis1-X(2)))) - tand(el1);
    
    F2 = (cosd(X(1)) * cosd(phis2-X(2)) - r_ratio) /...
        cos(asin(cosd(X(1)) * cosd(phis2-X(2)))) - tand(el2);
    
    F = [F1; F2];

    % Jacobian, J, for F(x0,y0) is:
    j11 = -sind(X(1))*cosd(phis1-X(2)) * (1-r_ratio*cosd(X(1))*cosd(phis1-X(2))) /...
         (1-cosd(X(1))^2*cosd(phis1-X(2))^2)^(3/2);
    j12 = cosd(X(1))*sind(phis1-X(2)) * (1-r_ratio*cosd(X(1))*cosd(phis1-X(2))) /...
         (1-cosd(X(1))^2*cosd(phis1-X(2))^2)^(3/2);
    j21 = -sind(X(1))*cosd(phis2-X(2)) * (1-r_ratio*cosd(X(1))*cosd(phis2-X(2))) /...
         (1-cosd(X(1))^2*cosd(phis2-X(2))^2)^(3/2);
    j22 = cosd(X(1))*sind(phis2-X(2)) * (1-r_ratio*cosd(X(1))*cosd(phis2-X(2))) /...
         (1-cosd(X(1))^2*cosd(phis2-X(2))^2)^(3/2);
    J = [j11, j12; j21, j22];

    % Newton's equation for a vector is defined as:
    % J*(x2 - x1) = -F
    % Or Delta X = inv(J)*-F

    disp('==================');
    loop = loop+1
    % Calculate Delta X
    DeltaX = J\-F % Equivalent to inv(J)*-F;

    % Calculate new X to feed into next iteration
    X = X + DeltaX
    
    scatter(X(2),X(1));
    %drawnow;

    dx_arr(loop) = norm(DeltaX);
    disp('==================');
end
figure;
plot(dx_arr(1:loop));