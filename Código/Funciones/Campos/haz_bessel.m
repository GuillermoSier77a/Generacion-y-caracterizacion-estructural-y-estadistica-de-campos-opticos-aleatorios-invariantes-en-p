% Generación de anillo

function [anillo] = haz_bessel(x,sigma,Amplitud,R_0)

r_exterior = R_0 + 2*sigma;   
r_interior = R_0 - 2*sigma;  

[X_anillo,Y_anillo] = meshgrid(x,x);

R = sqrt(X_anillo.^2 + Y_anillo.^2);

% % Anillo gaussiano
anillo = Amplitud * exp(-(R - R_0).^2 / (2*sigma^2));
anillo(R < r_interior | R > r_exterior) = 0;

% Anillo no gaussiano
% anillo = zeros(size(X_anillo));
% anillo(R < r_interior | R > r_exterior) = 0;
% anillo(R > r_interior & R < r_exterior) = Amplitud;

% -------------------------------------------------------------------------
end
