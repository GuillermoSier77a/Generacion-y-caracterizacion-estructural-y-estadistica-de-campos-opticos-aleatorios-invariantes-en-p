function [out] = circ(x,y,w)

% Calcula la distancia radial de cada punto respecto al origen
% del sistema de coordenadas.
R = sqrt(x.^2+y.^2);

% Genera una función circular binaria. Los puntos cuya distancia radial
% es menor o igual que w toman el valor 1, mientras que los puntos
% exteriores toman el valor 0.
out=R<=w;

end