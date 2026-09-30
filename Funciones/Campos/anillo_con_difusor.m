function [anillo_y_difusor, grosor, radio_exterior, size_grano_del_difusor] = anillo_con_difusor(ang_mayor,ang_menor,x,sigma,amplitud,num_granos,R_0)
    
    % Radio exterior del anillo.
    % Se consideran dos desviaciones estándar sigma respecto al radio R_0.
    radio_exterior = R_0 + 2*sigma;   
    
    % Radio interior del anillo.
    % Se consideran dos desviaciones estándar sigma hacia el interior respecto a R_0.
    radio_interior = R_0 - 2*sigma;  
    
    % Grosor total del anillo, calculado como la diferencia entre
    % el radio exterior y el radio interior.
    grosor = radio_exterior-radio_interior;
    
    % Genera las posiciones espaciales de los centros de los granos
    % del difusor a lo largo del intervalo definido por x.
    x_grano = linspace(min(x),max(x),num_granos);
    
    % Calcula el tamaño espacial de cada grano del difusor.
    size_grano_del_difusor = abs(x_grano(1)-x_grano(2));
    
    % Genera una malla bidimensional con las posiciones de los granos
    % del difusor en las direcciones X y Y.
    [X_grano,Y_grano] = meshgrid(x_grano,x_grano);
    
    % Genera una malla bidimensional utilizando todas las posiciones
    % espaciales definidas en x.
    [X_anillo,Y_anillo] = meshgrid(x,x);
    
    % Invertimos Y para que el difusor tenga la misma orientación que la mostrada con imagesc.
    Y_anillo = flipud(Y_anillo);
    
    % Genera una matriz de fases aleatorias distribuidas uniformemente
    % entre ang_menor y ang_mayor.
    angulo = ang_menor + (ang_mayor-ang_menor)*rand(size(X_grano));
    
    % Interpola la matriz de fases definida sobre la malla de los granos
    % para obtener una fase sobre toda la malla del anillo.
    % Se utiliza interpolación 'nearest', por lo que cada punto de la malla
    % del anillo recibe la fase del grano más cercano.
    fase = interp2(X_grano,Y_grano,angulo,X_anillo,Y_anillo,'nearest');
    
    % Calcula la distancia radial de cada punto de la malla respecto
    % al centro del sistema de coordenadas.
    R = hypot(X_anillo,Y_anillo);
    
    % Anillo gaussiano
    % Genera una distribución de amplitud con perfil gaussiano en la
    % dirección radial, centrada en el radio R_0.
    % anillo = amplitud * exp(-(R - R_0).^2 / sigma^2);
    
    % Anillo rect
    % Genera una alternativa de anillo con amplitud constante.
    % Esta sección está comentada y, por lo tanto, no se ejecuta.
    anillo = zeros(size(X_anillo));
    anillo(R > radio_interior & R < radio_exterior) = amplitud;
    
    % Elimina los puntos que se encuentran fuera de los radios interior
    % y exterior establecidos para el anillo.
    % En esos puntos la amplitud se establece igual a cero.
    anillo(R < radio_interior | R > radio_exterior) = 0;
    
    % Combina la amplitud del anillo con la fase del difusor.
    % exp(1j*fase) representa el factor de fase complejo.
    % El resultado es el campo óptico complejo del anillo con difusor.
    anillo_y_difusor=anillo.*exp(1j*fase);
   
end