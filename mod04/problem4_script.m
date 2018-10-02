% Problem4:
%
% Define two circles in a two-dimensional plane that overlap.
% Specify the centers of the two circles as points xa, ya and xb, yb.
% Use Newton’s method to find the two points x01, y01 and x02, y02
% at which the circles intersect. This is how GPS works.
% Specifically, the locations of the GPS satellites are known.
% A GPS receiver measures the distance to each satellite, thus
% defining a circle of position on the surface of the earth that
% corresponds to each satellite. The points at which the circles
% from multiple satellites intersect are computed, thus defining
% one’s location on the surface of the earth.

%% User defined inputs
% Initial inputs for centers of two circles
xa = 5;
ya = 5;

xb = 10;
yb = 10;

ra = 5;
rb = 5;

% Enter guess for intersection x0 and y0
x0 = 15;
y0 = 6;

%% Algorithm starts here
% Iterative input
X = [x0; y0];
DeltaX = [Inf; Inf];

%% Iterative portion starts here
loop = 0;
while (norm(DeltaX) ~= 0 && ~isnan(norm(DeltaX)))

    % Equations for our two circles are:
    F1 = (X(1) - xa)^2 + (X(2) - ya)^2 - ra^2;
    F2 = (X(1) - xb)^2 + (X(2) - yb)^2 - rb^2;
    F = [F1; F2];

    % Jacobian, J, for F(x0,y0) is:
    j11 = 2*(X(1) - xa);
    j12 = 2*(X(2) - ya);
    j21 = 2*(X(1) - xb);
    j22 = 2*(X(2) - yb);
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
    disp('==================');
end

