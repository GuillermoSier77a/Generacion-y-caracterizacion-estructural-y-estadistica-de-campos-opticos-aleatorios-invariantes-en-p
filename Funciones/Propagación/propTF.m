function[u2]=propTF(u1,L,lambda,z)

    % Obtiene el número de muestras en las dimensiones x e y del campo
    [M,N] = size(u1); 
    
    % Calcula el intervalo de muestreo espacial a partir del tamaño
    % de la ventana y del número de muestras
    dx = L/M; 
    
    % Define el vector de frecuencias espaciales en el eje x
    fx = linspace(-1/(2*dx),1/(2*dx)-1/L,M);
    
    % Genera las matrices de frecuencias espaciales FX y FY
    % correspondientes a los ejes x e y
    [FX,FY] = meshgrid(fx,fx);
    
    % Calcula la función de transferencia de Fresnel en el dominio
    % de las frecuencias espaciales
    H = exp(1j*2*pi*z/lambda)*exp(-1j*pi*lambda*z*(FX.^2+FY.^2));
    
    % Reordena el espectro de la función de transferencia para
    % hacer coincidir su distribución con la de la transformada de Fourier
    H = fftshift(H); 
    
    % Calcula la transformada bidimensional de Fourier del campo de
    % entrada, desplazando previamente su origen al centro
    U1 = fft2(fftshift(u1));
    
    % Multiplica el espectro del campo de entrada por la función
    % de transferencia de Fresnel
    U2 = H.*U1; 
    
    % Calcula la transformada inversa de Fourier y desplaza el origen
    % nuevamente para obtener el campo propagado en el dominio espacial
    u2 = ifftshift(ifft2(U2));
    
end