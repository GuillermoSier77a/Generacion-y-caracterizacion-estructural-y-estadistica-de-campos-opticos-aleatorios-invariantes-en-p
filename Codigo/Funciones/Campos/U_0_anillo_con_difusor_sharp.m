function [anillo_y_difusor, grosor, size_grano_del_difusor, R_0, sigma] = U_0_anillo_con_difusor_sharp(radio_exterior, ang_mayor,ang_menor,x,amplitud,num_granos,R_0)

    % Calculamos el grosor del anillo como la diferencia entre su radio
    % exterior y su radio interior R_0.
    grosor = 2*(radio_exterior-R_0);

    sigma = grosor/4;
    
    % Generamos el vector de coordenadas espaciales correspondiente a la malla
    % del difusor. El número de puntos por dimensión está determinado por
    % num_granos.
    x_grano = linspace(min(x),max(x),num_granos);

    % Calcula el tamaño espacial de cada grano del difusor.
    size_grano_del_difusor = abs(x_grano(1)-x_grano(2));
    
    % Construimos la malla bidimensional sobre la cual se generan los valores
    % aleatorios de fase del difusor.
    [X_grano,Y_grano] = meshgrid(x_grano,x_grano);
    
    % Construimos la malla espacial correspondiente al campo óptico con la
    % resolución definida por el vector x.
    [X_anillo,Y_anillo] = meshgrid(x,x);
    
    % Invertimos Y para que el difusor tenga la misma orientación que la mostrada con imagesc.
    Y_anillo = flipud(Y_anillo);
    
    % Generamos una distribución bidimensional de valores de fase aleatorios
    % uniformemente distribuidos entre los límites angulares ang_menor y
    % ang_mayor.
    angulo = ang_menor + (ang_mayor-ang_menor)*rand(size(X_grano));
    
    % Interpolamos la distribución aleatoria de fase sobre la malla espacial
    % del campo mediante interpolación por vecino más cercano. De esta manera,
    % cada grano conserva un valor de fase constante y se obtienen cambios
    % abruptos de fase entre granos adyacentes.
    fase = interp2(X_grano,Y_grano,angulo,X_anillo,Y_anillo,'nearest');
    
    % Calculamos la distancia radial de cada punto de la malla respecto al
    % origen para definir posteriormente la geometría del anillo.
    R = hypot(X_anillo,Y_anillo);
    
    % Anillo gaussiano
    % Genera una distribución de amplitud con perfil gaussiano en la
    % dirección radial, centrada en el radio R_0.
    anillo = amplitud * exp(-(R - R_0).^2 / sigma^2);

    % Anillo rect
    % Genera una alternativa de anillo con amplitud constante.
    % Esta sección está comentada y, por lo tanto, no se ejecuta.
    % anillo = zeros(size(X_anillo));
    % anillo(R > radio_interior & R < radio_exterior) = amplitud;

    % Incorporamos el difusor al anillo multiplicando su distribución de
    % amplitud por el factor de fase compleja. El campo resultante conserva
    % la geometría anular y presenta una fase aleatoria espacialmente
    % distribuida dentro de dicha región.
    anillo_y_difusor = anillo.*exp(1j*fase);
    
end