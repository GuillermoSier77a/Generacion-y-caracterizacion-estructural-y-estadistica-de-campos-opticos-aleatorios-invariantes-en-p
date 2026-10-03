function [u1, grosor, radio_exterior] = deltas_simetricas(x,sigma,amplitud,R_0,dphi,N)

    % Radio exterior del u1.
    % Se consideran dos desviaciones estándar sigma respecto al radio R_0.
    radio_exterior = R_0 + 2*sigma;   
    
    % Radio interior del u1.
    % Se consideran dos desviaciones estándar sigma hacia el interior respecto a R_0.
    radio_interior = R_0 - 2*sigma;  
    
    % Grosor total del u1, calculado como la diferencia entre
    % el radio exterior y el radio interior.
    grosor = radio_exterior-radio_interior;

    % Genera una malla bidimensional utilizando todas las posiciones
    % espaciales definidas en x.
    [X_anillo,Y_anillo] = meshgrid(x,x);

    % Calcula la distancia radial de cada punto de la malla respecto
    % al centro del sistema de coordenadas.
    R = hypot(X_anillo,Y_anillo);

    % Calcula el ángulo polar de cada punto.
    PHI = atan2(Y_anillo,X_anillo);

    % Inicializa la máscara.
    mask = zeros(size(X_anillo));

    % Separación angular entre deltas consecutivas.
    angulo_de_separacion = 2*pi/N;

    % Genera N deltas distribuidas uniformemente alrededor del anillo.
    for i = 1:N

        % Ángulo central de la delta i-ésima.
        phi_i = (i-1)*angulo_de_separacion;

        % Diferencia angular respecto al centro de la delta.
        % Esta expresión tiene en cuenta la periodicidad angular.
        delta_phi = angle(exp(1i*(PHI-phi_i)));

        % Selecciona los puntos contenidos dentro del intervalo angular
        % [-dphi/2,dphi/2] y dentro del grosor radial del anillo.
        mask(abs(delta_phi) <= dphi/2 & R > radio_interior & R < radio_exterior) = 1;

    end

    % Deltas gaussianas
    % Genera una distribución de amplitud con perfil gaussiano en la
    % dirección radial, centrada en el radio R_0.
    % anillo = amplitud * exp(-(R - R_0).^2 / sigma^2);
    % anillo(R < radio_interior | R > radio_exterior) = 0;

    % Deltas rect
    % Genera una alternativa de u1 con amplitud constante.
    % Esta sección está comentada y, por lo tanto, no se ejecuta.
    anillo = zeros(size(X_anillo));
    anillo(R > radio_interior & R < radio_exterior) = amplitud;

    % Elimina los puntos que se encuentran fuera de los radios interior
    % y exterior establecidos para el u1.
    % En esos puntos la amplitud se establece igual a cero.
    u1 = mask.*anillo;

end