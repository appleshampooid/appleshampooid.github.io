% Benjamin John Frevert, group 5, 15 of February 2006, ME 123, Speed 113

%get ready for data by clearing matlab out
clear
clc

% display quick reference of tee positions
fprintf('Tee  xtee  ytee theta2\n')
fprintf('1   20.5  2.25   94\n')
fprintf('2   68.5   14   113\n')
fprintf('3   77   19.5   117\n')
fprintf('4   88.5   26   122\n')

%set up constants
g = 32.2; %feet per second squared, gravitational constant
L = 12; %feet, length of arm
H = 12.5; %feet, height of pivot
h = (24 + 4 + 1.5) / 12; %feet, heigh of cup
mball = .6; %pounds, mass of ball
mbar = 26; %pounds, mass of bar
mclub = 2; %pounds, mass of club
e = .691; %coefficient of restitution
km = 0.0001; %drag coefficient
deltat = .0001; %time step

%input in of tee position inches, inches, degrees
xtee = input('xtee (inches):'); %tee position, x-direction, from pivot
ytee = input('ytee(inches):'); %tee position, y-direction, from below pivot
angle2 = input('angle 2(degreees):'); %impact angle, negative, from horizontal

%convert to tee position to feet
xtee = xtee / 12;
ytee = ytee / 12;

% convert angle of impact to radians
theta2 = angle2 * pi / 180;

% set up loop for row number position for final array
row = 0;

%loop for all angle that could hit target, at .1 degree increments
for angle1 = 0:.1:(180 - angle2)
    
    %row position number increase
    row = row + 1;
    
    %convert angle of release to radians
    theta1 = angle1 * pi / 180;
    
    %set up the intial velocity of the ball
    vtip = sqrt ( 3 * g * L * (sin (theta2) - sin (theta1)));
    vball = (1 + e)*(vtip)*(1 / (1 + (mball / ((mbar/3) + mclub))));

    %set up the initial y velocity and position
    vy = -1 * vball * cos(theta2);
    y = ytee;

    %set up the initial x velocity and position
    vx = -L * cos(theta2);
    x = xtee;

    %loop while x-position is above landing height or velocity positive
    while (y > h) | (vy > 0)
        %calculate new position and velocity of ball
        vx = vx - deltat * (0 - (km) * vx * sqrt(vx * vx + vy * vy));
        x = x + deltat * vx;
        vy = vy - deltat * (g - (km) * vy * sqrt(vx * vx + vy * vy));
        y = y + deltat * vy;
    end
    %place data in quick reference array
    table(row,3) = angle1;
    table(row,1) = x * 36;
    table(row,2) = x*3;
end

%print out quick reference array
fprintf('  x(in)       x(ft)   angle(degrees)\n')
fprintf('  %8.4f  %8.4f  %4.2f\n',table')
