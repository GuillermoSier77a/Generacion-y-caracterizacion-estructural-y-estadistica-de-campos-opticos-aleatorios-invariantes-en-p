function [haz_mathieu, grosor] = haz_mathieu(x,sigma,Amplitud,R_0,m,q)

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
haz_mathieu = zeros(size(X));

% Ángulos dentro del anillo
phi = Phi(mascara);

% -------------------------------------------------------
% Función angular de Mathieu
% -------------------------------------------------------

A_phi = mathieuce(m,q,phi);

% Normalización
A_phi = A_phi/max(abs(A_phi));

% -------------------------------------------------------

haz_mathieu(mascara) = Amplitud*A_phi;

end