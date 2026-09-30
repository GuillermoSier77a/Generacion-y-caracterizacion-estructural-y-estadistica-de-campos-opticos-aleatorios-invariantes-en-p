% Generación de has gaussiano

function [campo] = haz_gaussiano_exp(x,w_0,Amplitud)

% Genera una malla bidimensional utilizando todas las posiciones
% espaciales definidas en x.
[X_anillo,Y_anillo] = meshgrid(x,x);

Y_anillo = flipud(Y_anillo);

R = sqrt(X_anillo.^2 + Y_anillo.^2);

campo = Amplitud * exp(-R.^2/(w_0^2));
% -------------------------------------------------------------------------
end
