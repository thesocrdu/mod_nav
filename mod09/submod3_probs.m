%% User defined inputs
% Initial inputs to satelite locations
Ameas1 = 118.4; % Azimuth in degrees
phis1 = -27.5; % Satallite longitude in degrees

Ameas2 = 231.2; % Azimuth in degrees
phis2 = -115; % Satallite longitude in degrees

% Initial guess for location on Earth
thetae0 = 40; % Person's latitude
phie0 = -76;   % Person's longitude

%% Algorithm starts here
% Iterative input
X = [thetae0; phie0];
DeltaX = [Inf; Inf];

%% Iterative portion starts here
loop = 0;
dx_arr = ones(1000, 1);
figure; hold on;
while (norm(DeltaX) > 1e-5 && ~isnan(norm(DeltaX)))

    % Equations for our two circles are:
    F1 = sind(phis1-X(2)) / (-sind(X(1))*cosd(phis1-X(2))) - tand(Ameas1);
    F2 = sind(phis2-X(2)) / (-sind(X(1))*cosd(phis2-X(2))) - tand(Ameas2);
    F = [F1; F2];

    % Jacobian, J, for F(x0,y0) is:
    j11 = cotd(X(1)) * cscd(X(1)) * tand(phis1-X(2));
    j12 = cscd(X(1)) * secd(phis1-X(2))^2;
    j21 = cotd(X(1)) * cscd(X(1)) * tand(phis2-X(2));
    j22 = cscd(X(1)) * secd(phis2-X(2))^2;
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