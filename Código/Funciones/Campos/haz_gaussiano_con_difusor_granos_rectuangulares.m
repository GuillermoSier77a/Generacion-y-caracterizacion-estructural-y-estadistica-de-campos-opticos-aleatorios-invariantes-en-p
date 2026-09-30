% Generación de anillo con difusor

function [U_0] = haz_gaussiano_con_difusor_granos_rectuangulares(ang_mayor,ang_menor,x,amplitud,num_granos_x,num_granos_y,w_0)

x_grano = linspace(min(x),max(x),num_granos_x);

y_grano = linspace(min(x),max(x),num_granos_y);

[X_grano,Y_grano] = meshgrid(x_grano,y_grano);

[X_anillo,Y_anillo] = meshgrid(x,x);

% Invertimos Y para que el difusor tenga la misma orientación que la mostrada con imagesc.
Y_anillo = flipud(Y_anillo);

angulo = ang_menor + (ang_mayor-ang_menor)*rand(size(X_grano));

fase = interp2(X_grano,Y_grano,angulo,X_anillo,Y_anillo,'nearest');

R = hypot(X_anillo,Y_anillo);

% Haz gaussiano
campo = amplitud * exp(-R.^2/(w_0^2));

% % Haz circ
% campo = zeros(size(X_anillo));
% campo(R < w_0) = amplitud;

U_0 = campo.*exp(1j*fase);

end
