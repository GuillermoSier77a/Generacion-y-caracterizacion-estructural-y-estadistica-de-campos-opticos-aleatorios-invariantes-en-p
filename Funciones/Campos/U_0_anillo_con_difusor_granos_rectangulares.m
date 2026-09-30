% Generación de anillo con difusor

function [anillo_y_difusor, grosor]=U_0_anillo_con_difusor_granos_rectangulares(ang_mayor,ang_menor,x,sigma,amplitud,num_granos_x,num_granos_y,R_0)

r_exterior = R_0 + 2*sigma;   
r_interior = R_0 - 2*sigma;  

grosor = r_exterior-r_interior;

x_grano = linspace(min(x),max(x),num_granos_x);

y_grano = linspace(min(x),max(x),num_granos_y);

[X_grano,Y_grano] = meshgrid(x_grano,y_grano);

[X_anillo,Y_anillo] = meshgrid(x,x);

% Invertimos Y para que el difusor tenga la misma orientación que la mostrada con imagesc.
Y_anillo = flipud(Y_anillo);

angulo = ang_menor + (ang_mayor-ang_menor)*rand(size(X_grano));

fase = interp2(X_grano,Y_grano,angulo,X_anillo,Y_anillo,'nearest');

R = hypot(X_anillo,Y_anillo);

% Anillo gaussiano
anillo = amplitud * exp(-(R - R_0).^2 / sigma^2);

% % Anillo rect
% anillo = zeros(size(X_anillo));
% anillo(R > r_interior & R < r_exterior) = amplitud;

anillo(R < r_interior | R > r_exterior) = 0;
anillo_y_difusor = anillo.*exp(1j*fase);
end
