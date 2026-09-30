function [r_0,r_1,r_2,ordenadas,FWC25,FWC50,FWC75,autocorrelacion,idx_1,idx_2] = calculo_autocorrelaciones(R_0,I_ref_norm,x)

% Calculamos la autocorrelación bidimensional de la distribución de
% irradiancia normalizada en el plano de Fourier mediante el teorema
% de Wiener-Khinchin.
F = fft2(I_ref_norm);
autocorrelacion = fftshift(ifft2(F .* conj(F)));
autocorrelacion = abs(autocorrelacion);   
autocorrelacion = autocorrelacion/max(autocorrelacion(:));

% Generamos las matrices de coordenadas espaciales y calculamos la
% distancia radial de cada punto con respecto al origen.
[X,Y] = meshgrid(x,x);
R = hypot(X,Y);

% Identificamos la región de la autocorrelación cuyos valores son
% mayores o iguales al 25 % de su valor máximo.
mask_0 = autocorrelacion >= 0.25;

% Obtenemos las distancias radiales correspondientes a dicha región.
distancias_validas_0 = R(mask_0);

% Determinamos la máxima distancia radial para la cual la
% autocorrelación permanece por encima del nivel de 0.25.
[r_0, ~] = max(distancias_validas_0);

% Las siguientes líneas permiten localizar los índices correspondientes
% al punto más alejado dentro de la región definida por el nivel 0.25.
% [indxs_0, indys_0] = find(mask_0);
% fila_0 = indxs_0(indice_0);
% columna_0 = indys_0(indice_0);

% Calculamos el ancho completo de la autocorrelación al 25 % de su
% máximo (FWC25), normalizado con respecto al radio R_0.
FWC25 = 2*r_0/R_0;

% Extraemos el corte horizontal de la autocorrelación que pasa por
% su centro para analizar su perfil transversal.
ordenadas = autocorrelacion(floor(length(autocorrelacion)/2)+1,:);

% Identificamos la región de la autocorrelación cuyos valores son
% mayores o iguales al 50 % de su valor máximo.
mask_1 = autocorrelacion >= 0.50;

% Obtenemos las distancias radiales correspondientes a dicha región.
distancias_validas_1 = R(mask_1);

% Determinamos la máxima distancia radial para la cual la
% autocorrelación permanece por encima del nivel de 0.50.
[r_1, ~] = max(distancias_validas_1);

% Las siguientes líneas permiten localizar los índices correspondientes
% al punto más alejado dentro de la región definida por el nivel 0.50.
% [indxs_1, indys_1] = find(mask_1);
% fila_1 = indxs_1(indice_1);
% columna_1 = indys_1(indice_1);

% Calculamos el ancho completo de la autocorrelación al 50 % de su
% máximo (FWC50), normalizado con respecto al radio R_0.
FWC50 = 2*r_1/R_0;

% Identificamos, sobre el corte horizontal central, los puntos donde
% la autocorrelación es mayor o igual al 50 % de su valor máximo.
mask_3 = ordenadas >= 0.50;

% Obtenemos los índices del primer y último punto que satisfacen la
% condición anterior. Estos delimitan el ancho del perfil central
% al 50 % de su valor máximo.
idx_1 = find(mask_3,1,'first');
idx_2 = find(mask_3,1,'last');

% Identificamos la región de la autocorrelación cuyos valores son
% mayores o iguales al 75 % de su valor máximo.
mask_2 = autocorrelacion >= 0.75;

% Obtenemos las distancias radiales correspondientes a dicha región.
distancias_validas_2 = R(mask_2);

% Determinamos la máxima distancia radial para la cual la
% autocorrelación permanece por encima del nivel de 0.75.
[r_2, ~] = max(distancias_validas_2);

% Las siguientes líneas permiten localizar los índices correspondientes
% al punto más alejado dentro de la región definida por el nivel 0.75.
% [indxs_2, indys_2] = find(mask_2);
% fila_2 = indxs_2(indice_2);
% columna_2 = indys_2(indice_2);

% Calculamos el ancho completo de la autocorrelación al 75 % de su
% máximo (FWC75), normalizado con respecto al radio R_0.
FWC75 = 2*r_2/R_0;

end