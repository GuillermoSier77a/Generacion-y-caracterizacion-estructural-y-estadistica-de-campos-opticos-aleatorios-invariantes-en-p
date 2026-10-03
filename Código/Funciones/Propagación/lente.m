function [lente] = lente(x,f,k,w)

% Genera una malla bidimensional a partir de las posiciones espaciales
% definidas en el vector x.
[X,Y] = meshgrid(x,x);

% Calcula el cuadrado de la distancia radial de cada punto de la malla
% respecto al origen del sistema de coordenadas.
rho2 = X.^2 + Y.^2;

% Genera la función de transmisión compleja de la lente.
% El término circ(X,Y,w) limita espacialmente la lente a una apertura
% circular de radio w, mientras que la exponencial compleja representa
% la fase cuadrática asociada a la lente.
lente = circ(X,Y,w).*exp(-1j*k*(rho2)/(2*f));
end