% Transformation of circle into a symmetric airfoil
U = 3.0;                 
R = 1.0;                 

% Co-ordinates
x = linspace(-3,3,500);
y = linspace(-3,3,500);

[X,Y] = meshgrid(x,y);

% Complex-plane
z = X + 1i*Y;

% In polar coordinates
r = abs(z);
theta = atan2(Y,X);

% To avoid singularity
r(r < R) = R;

% Streamlines
psi_uniform = U .* r .* sin(theta);
psi_doublet = -U * R^2 .* sin(theta) ./ r;
psi = psi_uniform + psi_doublet;

% Circle Boundary
th = linspace(0,2*pi,500);
e = 0.08;                        % Horizontal offset
circle = -e + R*exp(1i*th);

% Kutta Zhukovsky Transformation
c = 0.9 * R;
z(abs(z)<R) = NaN;
zeta = z + (c^2)./z;

X_airfoil = real(zeta);
Y_airfoil = imag(zeta);

% Airfoil Boundary
airfoil = circle + (c^2)./circle;

% Stagnation points on the circle
x_s = [-e+R,-e-R];
y_s = [0,0];

% Stagnation points on the symmetrical airfoil
z_s = x_s + 1i*y_s;
zeta_s = z_s + (c^2)./z_s;

x_airfoil_s = real(zeta_s);
y_airfoil_s = imag(zeta_s);

% Subplots
figure

% Flow over a circle
subplot(1,2,1)

contour(X, Y, psi, 45, 'LineWidth',1)

hold on

plot(real(circle), imag(circle),'b', 'LineWidth',3)

% Stagnation points
plot(x_s,y_s,'ro','MarkerSize',8,'MarkerFaceColor','r')

axis equal

xlabel('x')
ylabel('y')

title('Flow Around Circle')

grid on

% Flow over a symmetric airfoil
subplot(1,2,2)

contour(X_airfoil, Y_airfoil, psi, 45, 'LineWidth',1)

hold on

plot(real(airfoil), imag(airfoil),'m', 'LineWidth',3)

% Transformed Stagnation points
plot(x_airfoil_s,y_airfoil_s,'ko','MarkerSize',8,'MarkerFaceColor','y')

axis equal

xlim([-3,3])
ylim([-3,3])

xlabel('\xi')
ylabel('\eta')

title('Joukowski Symmetric Airfoil')

grid on