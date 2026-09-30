% Propagación teórica de un haz gaussiano

function[campo] = haz_gaussiano_teorico(x,z_R,z,k,w_0,R_z)

U_0 = 1;                        % Amplitud compleja del haz gaussiano
w_z = w_0*sqrt(1+(z/z_R)^2);    % Radio del haz
psi_z = atan(z/z_R);            % Fase de Gouy

[X,Y] = meshgrid(x,x);

rho2 = X.^2 + Y.^2;

if z == 0
    campo = U_0*(w_0/w_z).*exp(-rho2/(w_z^2));
else
    campo = U_0*(w_0/w_z).*exp(-rho2/(w_z^2)).*exp(1j*k*z+1j*((k*rho2)/(2*R_z))-1j*psi_z);
end
% -------------------------------------------------------------------------
end
