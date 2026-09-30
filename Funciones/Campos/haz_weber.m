% Generación de anillo

function [anillo, grosor] = haz_weber(x,sigma,Amplitud,R_0,a)

% Coordenadas
[X,Y] = meshgrid(x,x);

R   = hypot(X,Y);
Phi = atan2(Y,X);

% Anillo
r_exterior = R_0 + 2*sigma;
r_interior = R_0 - 2*sigma;

grosor = r_exterior-r_interior;

mascara = (R >= r_interior) & (R <= r_exterior);

% Inicialización
anillo = zeros(size(X));

% Ángulos dentro del anillo
phi = Phi(mascara);

% -------------------------------------------------------
% Fase Weber regularizada
% -------------------------------------------------------

t = abs(tan(phi/2));

% Evitar log(0)
t_min = 1e-10;
t(t < t_min) = t_min;

fase_weber = a*log(t);

% Reducir la fase módulo 2π
fase_weber = mod(fase_weber,2*pi);

A_phi = exp(1i*fase_weber);

% -------------------------------------------------------

anillo(mascara) = Amplitud*A_phi;

end