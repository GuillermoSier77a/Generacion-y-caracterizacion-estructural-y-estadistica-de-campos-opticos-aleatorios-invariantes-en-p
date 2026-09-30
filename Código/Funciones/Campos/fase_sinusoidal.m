% Función de transmisión de fase sinusoidal

function [campo] = fase_sinusoidal(x,a,b)

[X,Y] = meshgrid(x,x);

campo = exp(1j*pi*sin((2*pi*X)/b)).*rect(X,a).*rect(Y,a);

end
