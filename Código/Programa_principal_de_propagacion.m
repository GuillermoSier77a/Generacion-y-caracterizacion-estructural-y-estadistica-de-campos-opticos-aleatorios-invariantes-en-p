% PROGRAMA PRINCIPAL DE SIMULACIÓN Y ANÁLISIS DE PROPAGACIÓN ÓPTICA

% Este programa simula la propagación de distintos campos ópticos mediante
% el método de la función de transferencia de Fresnel a través de un sistema
% que incluye una lente positiva. Durante la propagación se calcula la
% distribución transversal de irradiancia y la potencia óptica en cada
% plano, así como el coeficiente de correlación de Pearson con respecto al
% patrón de irradiancia obtenido en el plano de Fourier de la lente.

% A partir del patrón de irradiancia en el plano de Fourier se calcula su
% autocorrelación espacial y se obtienen parámetros característicos de su
% estructura. Asimismo, se realiza un análisis mediante filtrado pasa bandas
% basado en diferencias de gaussianas (DoG).

% El programa genera un video de la evolución del patrón de irradiancia y
% su perfil transversal durante la propagación, además de las gráficas
% correspondientes a los campos, la potencia, la correlación y la
% autocorrelación.

% Para cada simulación se generan archivos TXT y CSV que funcionan como
% bitácora, en los cuales se almacenan los parámetros de propagación y los
% resultados numéricos obtenidos. Cuando se realizan múltiples simulaciones,
% el programa analiza conjuntamente los resultados y genera gráficas
% comparativas.

%--------------------------------------------------------------------------

% Cerramos todas las figuras, vaciamos el workspace y depuramos la
% ventana de comando.
close all; clear; clc;

% Añadimos al path de MATLAB la carpeta "Funciones" y todos sus
% subdirectorios para permitir el acceso a las funciones auxiliares.
addpath(genpath(fullfile(pwd,'Funciones')));

% Indicamos el inicio de la ejecución del programa.
disp('INICIANDO')
disp(' ')

% Iniciamos el cronómetro para medir el tiempo total de ejecución.
tic_total = tic;

% Número de simulaciones que se realizarán
numero_de_simulaciones = 1;

% Variable que indica si las condiciones de la simulación son válidas
validez = 1;

% Ruta principal donde se almacenarán todos los resultados
nombre_de_la_carpeta = 'Simulación de verificación';
ruta_base = fullfile(fileparts(fileparts(matlab.desktop.editor.getActiveFilename)),nombre_de_la_carpeta);

% Ruta donde se crearán las carpetas individuales de cada simulación
ruta_de_carpeta_de_simulaciones = fullfile(ruta_base,'Simulaciones');

% Si la carpeta ya existe, eliminarla junto con todo su contenido
% Esto permite comenzar cada ejecución con una carpeta de resultados limpia
if isfolder(ruta_base)

    rmdir(ruta_base,'s');   % 's' = elimina la carpeta y todo lo que contiene

end
 
% -------------------------------------------------------------------------
% Bucle principal: se ejecuta una simulación por cada valor de i
% -------------------------------------------------------------------------
for i = 1:numero_de_simulaciones

    % Iniciamos un cronómetro para medir el tiempo total de la simulación
    tic;

    % Estilo-------------------------------------------------------------------

    % Número identificador de la simulación actual
    num_prueba = i;

    % Creación de la carpeta

    % Se crea una carpeta independiente para almacenar los resultados
    % correspondientes a la simulación actual
    ruta = fullfile(ruta_de_carpeta_de_simulaciones,sprintf('Simulación %d',num_prueba));
    mkdir(ruta);

    % Nombre de los archivos

    % Archivo con la potencia del campo a lo largo de la propagación.
    % filename_0 = fullfile(ruta,'Validación de la propagación.png');

    % Archivo con la potencia del campo a lo largo de la propagación.
    filename_1 = fullfile(ruta,'Evolución de la potencia óptica.png');

    % Archivo con el campo de referencia y su correlación.
    filename_2 = fullfile(ruta,'Evolución de la invariancia.png');

    % Archivos correspondientes a la autocorrelación.
    filename_3_0 = fullfile(ruta,'Anillos de autocorrelación.png');

    filename_3_1 = fullfile(ruta,'Perfil de autocorrelación 0-1.png');

    filename_3_2 = fullfile(ruta,'Perfil de autocorrelación 0.50-1.png');

    filename_3_3 = fullfile(ruta,'Perfil de autocorrelación 0-0.50.png');

    % Archivo GIF de la propagación.
    % filename_4 = fullfile(ruta,'Propagación.gif');

    % Archivo de texto con los parámetros utilizados en la simulación.
    filename_5 = fullfile(ruta,'Parámetros y resultados de propagación.txt');

    % Archivo CSV con los resultados numéricos de la simulación.
    filename_6 = fullfile(ruta,'Parámetros y resultados de propagación.csv');

    % Archivo que contiene las gráficas comparativas entre simulaciones.
    filename_7_g = fullfile(ruta_base,'Evolución de FWC_0.50.png');

    filename_7_s = fullfile(ruta_base,'Evolución de FWC_0.75.png');

    filename_7_l = fullfile(ruta_base,'Evolución de FWC_0.25.png');

    % Archivo que contiene las gráficas comparativas entre simulaciones.
    filename_8 = fullfile(ruta_base,'Tiempo de cómputo.png');

    % Archivo que contiene las gráficas comparativas entre simulaciones.
    filename_9 = fullfile(ruta_base,'Evolución de potencias promedio.png');

    % Archivo que contiene las gráficas comparativas entre simulaciones.
    filename_10 = fullfile(ruta_base,'Evolución de coeficientes de correlación promedio.png');

    % Archivo con el campo inicial.
    filename_11 = fullfile(ruta,'Campo inicial.png');

    % Archivo con el campo en el plano de Fourier.
    filename_12 = fullfile(ruta,'Campo en el plano de Fourier.png');

    % Archivo con el campo en el plano de Fourier.
    filename_13 = fullfile(ruta,'Campo en el plano de la lente.png');

    % Archivo con el campo en el plano de Fourier.
    filename_14 = fullfile(ruta,'Campo en z=3f.png');

    % Archivo con el campo en el plano de Fourier sin envolvente.
    % filename_15 = fullfile(ruta,'Campo en el plano de Fourier sin envolvente.png');

    % Archivo con el perfil de irradiancia del campo en el plano de Fourier sin envolvente.
    % filename_16 = fullfile(ruta,'Perfil de irradiancia del campo en el plano de Fourier sin envolvente.png');

    % Nombre del archivo de video donde se almacenará la propagación.
    video_filename = fullfile(ruta,'Video de propagación.mp4');

    % Estilo-------------------------------------------------------------------

    % Seleccionamos el mapa de colores que se utilizará en las gráficas
    estilo = 'parula';                            

    % Creamos el objeto encargado de generar el video
    video = VideoWriter(video_filename,'MPEG-4');

    % Número de cuadros por segundo del video (fps)
    video.FrameRate = 5;                            

    % Calidad del video
    calidad_de_video = 100;
    video.Quality = calidad_de_video;

    % Abrimos el archivo de video para comenzar a escribir frames
    open(video);

    % Resolución utilizada posteriormente para guardar las gráficas
    resolucion = 300;

    % Lente--------------------------------------------------------------------

    % Distancia focal de la lente [cm]
    distancia_focal = 15; 

    % Radio de la pupila circular [cm]
    r_pupila = 2.54/2;     

    % Fuente de luz------------------------------------------------------------

    % Longitud de onda de la fuente de luz [cm]
    lambda = 532*10^-7;   

    % Número de onda
    k = 2*pi/lambda;       

    % Parámetros de propagación------------------------------------------------

    % Selección del tipo de propagación:
    % 1 = propagación paralela
    % 2 = propagación transversal
    propagacion = 1;   

    % -------------------------------------------------------------------------
    % Parámetros para propagación paralela
    % -------------------------------------------------------------------------
    if propagacion == 1

        % Factor de magnificación utilizado para definir el tamaño de la
        % ventana espacial
        magnificacion = 7;

        % Tamaño total de la ventana de cálculo [cm]
        L = 2*0.1*magnificacion;                

        % Número de muestras espaciales en cada dirección
        M = 2^11;

        % Número de frames de propagación (debe ser múltiplo de 3)
        numero_de_frames = 16*3;

        % Distancia máxima de propagación [cm]
        z_max = 3*distancia_focal;

        % % Distancia de Rayleigh
        % z_R = (k*0.1^2)/2;
        % z_max = 3*z_R;         

        % Tamaño de paso de propagación
        paso_z = z_max/numero_de_frames;       

        % Ancho del intervalo de muestreo
        dx = L/M;                               

        % Vector de coordenadas espaciales para los ejes x y y
        x = -L/2:dx:L/2-dx;
        
        % Índice correspondiente aproximadamente al centro de la matriz
        ordenada = floor(M/2)+1;
        
        % Vector de posiciones de propagación en z
        vector_z = 0:paso_z:z_max;
        
        % Crear una ventana de Tukey para reducir efectos de borde
        w = single(tukeywin(M,0.1));
        
        % Construir la ventana bidimensional a partir del producto exterior
        soporte = w*w.';

    % -------------------------------------------------------------------------
    % Parámetros para propagación transversal
    % -------------------------------------------------------------------------
    elseif propagacion == 2

        % Magnificación utilizada en esta configuración
        magnificacion = 100;                   

        % Tamaño de la ventana espacial [cm]
        L = 0.5*magnificacion;               

        % Número de muestras espaciales
        M = 2^13;

        % Tamaño de paso de propagación
        paso_z = z_max/numero_de_frames;   

        % Ancho del intervalo de muestreo
        dx = L/M;  

        % Vector de coordenadas espaciales para los ejes x y y
        x = -L/2:dx:L/2-dx;

        % Distancia máxima de propagación
        z_max = 2*distancia_focal;              

        % Índice correspondiente aproximadamente al centro de la matriz
        ordenada = floor(M/2)+1;
        
        % Vector de posiciones de propagación en z
        vector_z = 0:paso_z:z_max;
        
    end
    
    % Elección del campo a propagar--------------------------------------------
        
    % Lista de campos disponibles:
    
    % 1 = Haz gaussiano.
    % 2 = Anillo gaussiano con difusor.
    % 3 = Rejilla de fase sinusoidal (problema de la tarea 3)
    % 4 = Rejilla de amplitud horizontal
    % 5 = Haz Bessel
    % 6 = Haz Mathieu
    % 7 = Haz Weber
    % 8 = Deltas simétricas.
    % 9 = Deltas asimétricas
    % 10 = Vórtice
    % 11 = Haz gaussiano con difusor

    % Seleccionar el tipo de campo inicial
    campo_propagado = 2;
    
    switch campo_propagado
    
        %----------------------------------------------------------------------
        case 1  % Haz gaussiano
        %----------------------------------------------------------------------
    
            % Radio de la cintura del haz [cm]
            w_0 = 1/10;

            radio_exterior = w_0;
            size_grano_del_difusor_x = NaN;
            size_grano_del_difusor_y = NaN;
            R_0 = NaN;
            grosor = NaN;
            num_granos = NaN;
            ang_mayor = NaN;
            ang_menor = NaN;

            % Amplitud del campo
            amplitud = 1;
    
            % Generar el campo gaussiano
            [u1] = haz_gaussiano_exp(x,w_0,amplitud);

        %----------------------------------------------------------------------
        case 2  % Anillo gaussiano con difusor
        %----------------------------------------------------------------------
    
            % Número de granos utilizados para generar el difusor
            num_granos = 1000;

            % Número de granos en las direcciones x y y
            num_granos_x = 2^11;
            num_granos_y = 2^11;
    
            % Radio central del anillo gaussiano [cm]
            R_0 = 0.05;

            % Desviación estándar del anillo gaussiano [cm]
            sigma = (10)*10^-4;

            % Amplitud del campo
            amplitud = 1;
    
            % Límites angulares del difusor
            ang_mayor = 2*pi;
            ang_menor = 0;
    
            % Generar el anillo gaussiano con difusor
            [u1, grosor, radio_exterior, size_grano_del_difusor] = anillo_con_difusor(ang_mayor,ang_menor,x,sigma,amplitud,num_granos,R_0);
            size_grano_del_difusor_x = size_grano_del_difusor;
            size_grano_del_difusor_y = size_grano_del_difusor;

            % Transición
            % radio_exterior = 0.1;
            % [u1, grosor, size_grano_del_difusor, R_0, sigma] = U_0_anillo_con_difusor_sharp(radio_exterior, ang_mayor,ang_menor,x,amplitud,num_granos,R_0);
            % size_grano_del_difusor_x = size_grano_del_difusor;
            % size_grano_del_difusor_y = size_grano_del_difusor;

            % Alternativa para utilizar granos rectangulares
            % [u1, grosor] = U_0_anillo_con_difusor_granos_rectangulares(ang_mayor,ang_menor,x,sigma,amplitud,num_granos_x,num_granos_y,R_0);
    
        %----------------------------------------------------------------------
        case 3  % Rejilla de fase sinusoidal
        %----------------------------------------------------------------------
    
            % Diámetro de la pupila [cm]
            D = 1;
    
            % Distancia focal de la lente [cm]
            f = 100;
    
            % Parámetro Delta [cm]
            Delta = 1;
    
            % Posición característica [cm]
            X = 0.01;
    
            % Generar la rejilla de fase sinusoidal
            u1 = fase_sinusoidal(x,Delta,X);

        %----------------------------------------------------------------------
        case 4  % Rejilla de amplitud horizontal
        %----------------------------------------------------------------------
    
            % Número de franjas
            N = 30;
    
            % Separación entre las franjas [cm]
            Lambda = L/(magnificacion*N);
    
            % Grosor de las franjas [cm]
            X = Lambda/2;
    
            % Generar la rejilla de amplitud horizontal
            u1 = rejilla_horizontal(x,X,Lambda,N,L/magnificacion);
    
        %----------------------------------------------------------------------
        case 5  % Haz Bessel
        %----------------------------------------------------------------------
    
            % Radio central del anillo [cm]
            R_0 = 0.05;
    
            % Desviación estándar del anillo [cm]
            sigma = 20*10^-4;
    
            % Amplitud del campo
            amplitud = 1;
    
            % Generar el campo tipo Bessel
            u1 = haz_bessel(x,sigma,amplitud,R_0);
    
        %----------------------------------------------------------------------
        case 6  % Haz Mathieu
        %----------------------------------------------------------------------
    
            % Radio central del anillo [cm]
            R_0 = 0.1;
    
            % Desviación estándar del anillo [cm]
            sigma = 0.001;
    
            % Amplitud del campo
            amplitud = 1;
    
            % Parámetros del haz de Mathieu
            m = 10;
            q = 20;
    
            % Generar el campo tipo Mathieu
            [u1, grosor] = haz_mathieu(x,sigma,amplitud,R_0,m,q);
    
        %----------------------------------------------------------------------
        case 7  % Haz Weber
        %----------------------------------------------------------------------
    
            % Radio central del anillo [cm]
            R_0 = 0.1;
    
            % Desviación estándar del anillo [cm]
            sigma = 0.001;
    
            % Amplitud del campo
            amplitud = 1;
    
            % Parámetro del haz de Weber
            a = 20;
    
            % Generar el campo tipo Weber
            [u1, grosor] = haz_weber(x,sigma,amplitud,R_0,a);
    
        %----------------------------------------------------------------------
        case 8  % Deltas simétricas
        %----------------------------------------------------------------------
    
            % Radio central del anillo [cm]
            R_0 = 0.05;
    
            % Desviación estándar del anillo
            sigma = (10)*10^-4;
    
            % Amplitud del campo
            amplitud = 1;
    
            % Número de deltas
            N = 6;
    
            % Grosor angular de cada delta [rad]
            dphi = (1.5*i)*pi/180;

            % Generar el campo con deltas simétricas
            [u1, grosor, radio_exterior] = deltas_simetricas(x,sigma,amplitud,R_0,dphi,N);
            size_grano_del_difusor_x = NaN;
            size_grano_del_difusor_y = NaN;
            num_granos = NaN;
            ang_mayor = NaN;
            ang_menor = NaN;

        %----------------------------------------------------------------------
        case 9  % Deltas asimétricas
        %----------------------------------------------------------------------
    
            % Radio central del anillo [cm]
            R_0 = 0.1;
    
            % Desviación estándar del anillo
            sigma = 0.001;
    
            % Amplitud del campo
            amplitud = 1;
    
            % Grosor angular de la delta [rad]
            dphi = 2*pi/180;

            % Número de deltas 
            N = 2*pi/180;
    
            % Generar el campo con deltas asimétricas
            [u1, grosor] = anillo_deltas_3(x,sigma,amplitud,R_0,dphi);
    
        %----------------------------------------------------------------------
        case 10  % Vórtice
        %----------------------------------------------------------------------
    
            % Radio central del anillo [cm]
            R_0 = 0.1;
    
            % Desviación estándar del anillo [cm]
            sigma = 0.001;
    
            % Amplitud del campo
            amplitud = 1;
    
            % Carga topológica o parámetro azimutal
            m = 5;
    
            % Generar el campo de vórtice
            u1 = anillo_vortices(x,sigma,amplitud,R_0,m);
    
        %----------------------------------------------------------------------
        case 11  % Haz gaussiano con difusor
        %----------------------------------------------------------------------
    
            % Número de granos utilizados en el difusor
            num_granos = 1000;
    
            % Número de granos en las direcciones x y y
            num_granos_x = 2^11;
            num_granos_y = 100*i;
    
            % Radio de la cintura del haz [cm]
            w_0 = 0.005*20;
    
            % Amplitud del campo
            amplitud = 1;
    
            % Límites angulares del difusor
            ang_mayor = 2*pi;
            ang_menor = 0;
    
            % Generar el haz gaussiano con difusor
            [u1] = haz_gaussiano_con_difusor(ang_mayor,ang_menor,x,amplitud,num_granos,w_0);
    
            % Alternativa para utilizar granos rectangulares
            
            % [u1] = haz_gaussiano_con_difusor_granos_rectuangulares(ang_mayor,ang_menor,x,amplitud,num_granos_x,num_granos_y,w_0);
    
        %----------------------------------------------------------------------
        otherwise
        %----------------------------------------------------------------------
    
            % Mostrar un error si se selecciona una opción inexistente
            error('El valor de campo_propagado debe estar entre 1 y 11.');
    
    end

    % -------------------------------------------------------------------------
    % Índice de la lente y del plano focal
    % -------------------------------------------------------------------------

    % Encontramos el índice del elemento de vector_z más cercano a la
    % posición de la lente
    [~,posicion_de_la_lente] = min(abs(vector_z - distancia_focal));

    % Encontramos el índice del elemento de vector_z más cercano al plano
    % de Fourier, situado a una distancia 2f
    [~,posicion_del_plano_de_Fourier] = min(abs(vector_z - 2*distancia_focal));

    % Encontramos el índice del elemento de vector_z más cercano a la
    % posición 3f
    [~,posicion_3f] = min(abs(vector_z - 3*distancia_focal));

    % Propagador---------------------------------------------------------------

    % Mostramos en la ventana de comandos el inicio de la simulación
    disp(['Iniciando simulación ',num2str(num_prueba),'/',num2str(numero_de_simulaciones),'.'])

    % El anillo está contenido en el cuadrado inscrito en la pupila
    % cuando el radio exterior cumple la condición indicada.
    %
    % Además, el tamaño de la ventana debe ser suficientemente grande para
    % contener completamente el diámetro del anillo.
    %
    % (R_0 < sqrt(2)*r_pupila*0.5 - 2*sigma) && (2*(R_0+2*sigma) < L)

    if (R_0 < sqrt(2)*r_pupila*0.5 - 2*sigma) && (2*(R_0+2*sigma) < L)

        % Reproduce el sonido asociado al inicio de una simulación válida
        % tono

        disp(' ')
        disp('Se han satisfecho los criterios de muestreo.')
        disp(' ')

        % ---------------------------------------------------------------------
        % Esqueleto del video
        % ---------------------------------------------------------------------

        % Creamos una figura invisible que contendrá la animación
        fig = figure('Visible',"off","Units", 'pixels', 'Position', [100, 100, 1600, 800]);

        % Dividimos la figura en dos paneles
        tl = tiledlayout(fig,1,2, 'TileSpacing','compact', 'Padding','compact');

        % ---------------------------------------------------------------------
        % Subfigura izquierda
        % ---------------------------------------------------------------------

        % Seleccionamos el primer panel
        ax1 = nexttile(tl);

        % Creamos una imagen inicialmente llena de ceros.
        % Posteriormente CData será reemplazado por la irradiancia.
        hImg = imagesc(ax1,x/lambda,x/lambda,zeros(M));

        % Colocamos el eje y en orientación ascendente
        set(ax1,'YDir','normal')

        % Etiquetas de los ejes
        xlabel(ax1,'Eje x [λ]','FontWeight','bold');
        ylabel(ax1,'Eje y [λ]','FontWeight','bold');

        % Aplicamos el mapa de colores
        colormap(ax1,estilo)

        % Creamos la barra de color
        cb1 = colorbar(ax1);
        ylabel(cb1,'Irradiancia [U.A.]','FontWeight','bold')

        % Tamaño de letra de los elementos de la gráfica
        set(ax1,'FontSize',15,'FontWeight','bold')

        % Mantenemos la misma escala en ambos ejes
        axis(ax1,'equal')

        % Ajustamos los límites a los datos
        axis(ax1,'tight')

        % Relación de aspecto cuadrada
        pbaspect(ax1,[1 1 1])

        % Título que será actualizado durante la propagación
        t1 = title(ax1,'');

        % ---------------------------------------------------------------------
        % Subfigura derecha
        % ---------------------------------------------------------------------

        % Seleccionamos el segundo panel
        ax2 = nexttile(tl);

        % Creamos el perfil de irradiancia inicial.
        % Posteriormente YData será actualizado en cada frame.
        hPlot = plot(ax2,x/lambda,zeros(size(x)), 'LineWidth',1, 'Color','r');

        % hold on
        % 
        % % Creamos el perfil de irradiancia teórico.
        % % Posteriormente YData será actualizado en cada frame.
        % hPlot_2 = plot(ax2,x/lambda,zeros(size(x)), 'LineWidth',1, 'Color','b','LineStyle','--');
        % 
        % legend(ax2,[hPlot,hPlot_2],{'Numérico','Analítico'},'Location','northwest');

        % Etiqueta del eje horizontal
        xlabel(ax2,'Eje x [λ]','FontWeight','bold');

        % Tamaño de letra
        set(ax2,'FontSize',15,'FontWeight','bold')

        % Ajustamos los límites de la gráfica
        axis(ax2,'tight')

        % Relación de aspecto cuadrada
        pbaspect(ax2,[1 1 1])

        % Activamos cuadrícula principal y secundaria
        grid(ax2,'on')
        grid(ax2,'minor')

        % Título que será actualizado durante la propagación
        t2 = title(ax2,'');

        % ---------------------------------------------------------------------
        % Definición de variables auxiliares
        % ---------------------------------------------------------------------

        % Vector donde se almacenará el CCP entre campo y la expresión analítica en cada z
        % comprobacion = zeros(1,length(vector_z));

        % Vector donde se almacenará la potencia total del campo en cada z
        Potencia = zeros(1,length(vector_z));

        % Vector para almacenar la correlación con respecto al plano de Fourier
        pearson = nan(1,length(vector_z)-posicion_de_la_lente+1);

        % Matriz donde se almacenará la irradiancia de los planos ubicados
        % entre la lente y el plano de Fourier
        Irradiancias = zeros(M,M,floor((length(vector_z)-posicion_de_la_lente)/2),'single');

        % ---------------------------------------------------------------------
        % Propagación paralela
        % ---------------------------------------------------------------------
        if propagacion == 1

            % Recorremos todos los planos de propagación
            for g = 1:length(vector_z)

                % -------------------------------------------------------------
                % Primer frame: campo inicial
                % -------------------------------------------------------------
                if g == 1

                    % Calculamos la irradiancia inicial:
                    I1 = single(abs(u1).^2); 

                    % Actualizamos la imagen 2D
                    set(hImg,'CData',I1);

                    % Actualizamos el título indicando el frame y la posición z
                    t1.String = sprintf(['Simulación ',num2str(num_prueba),' (z = 0)']);

                    % Mostramos el perfil horizontal correspondiente a la
                    % fila central de la matriz
                    set(hPlot,'YData',I1(ordenada,:));

                    % % Radio de curvatura del frente de onda
                    % R_z = 0;
                    % p_z = 0;
                    % 
                    % % Generar el campo gaussiano teórico
                    % u1_teorico = haz_gaussiano_teorico(x,z_R,p_z,k,w_0,R_z);
                    % 
                    % % Calculamos la irradiancia inicial:
                    % I1_teorico = single(abs(u1_teorico).^2); 
                    % 
                    % % Mostramos el perfil horizontal teórico
                    % set(hPlot_2,'YData',I1_teorico(ordenada,:));
                    % 
                    % Campo_A = I1/sum(I1(:));
                    % Campo_B = I1_teorico/sum(I1_teorico(:));
                    % comprobacion(g) = corr2(Campo_A,Campo_B);

                    % Título del perfil
                    t2.String = sprintf(['Simulación ',num2str(num_prueba),' (y = ',num2str(x(ordenada)),', z = 0)']);

                    % Potencia total del campo inicial.
                    % La suma de la irradiancia se multiplica por dx^2,
                    % correspondiente al área de cada elemento de muestreo.
                    Potencia(g)=sum(I1,'all')*dx^2;

                    % Descomentar la siguiente línea para generar un GIF:
                    % imwrite(A,map,filename_4,'gif','LoopCount',Inf,'DelayTime',0.2); % Frame 0

                % -------------------------------------------------------------
                % Frames posteriores: propagación del campo
                % -------------------------------------------------------------
                else

                    % Aplicamos la ventana de Tukey para reducir efectos de
                    % borde antes de realizar la siguiente propagación
                    u1 = u1.*soporte;

                    % Propagamos el campo una distancia paso_z utilizando
                    % la función de transferencia de Fresnel (H)
                    u2 = propTF(u1,L,lambda,paso_z); 

                    % Calculamos la irradiancia del campo propagado
                    I2 = single(abs(u2).^2);      

                    if g == posicion_de_la_lente
                        I_lente = I2;
                    elseif g == posicion_3f
                        I_3f = I2;
                    end

                    % Actualizamos la imagen 2D
                    set(hImg,'CData',I2); 

                    % Actualizamos el título
                    t1.String = sprintf(['Simulación ',num2str(num_prueba),' (z = ',num2str(vector_z(g)/distancia_focal),'f)']);

                    % Actualizamos el perfil central de irradiancia
                    set(hPlot,'YData',I2(ordenada,:));

                    % % Radio de curvatura del frente de onda
                    % p_z = vector_z(g);
                    % R_z = p_z*(1+(z_R/p_z)^2);
                    % 
                    % % Generar el campo gaussiano teórico
                    % u1_teorico = haz_gaussiano_teorico(x,z_R,p_z,k,w_0,R_z);
                    % 
                    % % Calculamos la irradiancia inicial:
                    % I1_teorico = single(abs(u1_teorico).^2); 
                    % 
                    % % Mostramos el perfil horizontal teórico
                    % set(hPlot_2,'YData',I1_teorico(ordenada,:));
                    % 
                    % Campo_A = I2/sum(I2(:));
                    % Campo_B = I1_teorico/sum(I1_teorico(:));
                    % comprobacion(g) = corr2(Campo_A,Campo_B);

                    % Actualizamos el título del perfil
                    t2.String = sprintf(['Simulación ',num2str(num_prueba),' (y = ',num2str(x(ordenada)),', z = ',num2str(vector_z(g)/distancia_focal),'f)']);

                end

                % -------------------------------------------------------------
                % Capturamos el frame actual
                % -------------------------------------------------------------

                % Actualizamos la figura antes de capturarla
                drawnow limitrate

                % Capturamos la figura como un frame
                frame = getframe(fig);

                % Descomentar las siguientes líneas para generar un GIF:
                % img = frame2im(frame);
                % [A,map] = rgb2ind(img,256);

                % Escribimos el frame actual en el video MP4
                writeVideo(video,frame);

                % -------------------------------------------------------------
                % Cálculo de la potencia
                % -------------------------------------------------------------

                if g ~= 1  

                    % Potencia total del campo propagado
                    Potencia(g)=sum(I2,'all')*dx^2;

                    % Descomentar la siguiente línea para generar un GIF:
                    % imwrite(A,map,filename_4,'gif','WriteMode','append','DelayTime',0.2); % Frames siguientes

                    % ---------------------------------------------------------
                    % Guardado de irradiancias entre la lente y el plano de Fourier
                    % ---------------------------------------------------------
                    if (posicion_de_la_lente <= g) && (g < posicion_del_plano_de_Fourier)

                        % Guardamos la irradiancia del plano actual
                        Irradiancias(:,:,g-posicion_de_la_lente+1) = I2;
                    
                    % ---------------------------------------------------------
                    % Plano de Fourier
                    % ---------------------------------------------------------
                    elseif g == posicion_del_plano_de_Fourier

                        % La irradiancia en este plano se utiliza como
                        % referencia para calcular la correlación.

                        I_ref = I2;

                        % Normalizamos la irradiancia de referencia para que
                        % la suma de todos sus elementos sea igual a 1
                        I_ref_norm = I2/sum(I2(:));

                        % envo = 20*i;
                        % 
                        % quitar_envolvente(envo,I_ref_norm,vector_z,g,filename_14,ordenada,I_ref,x,num_granos,filename_13,resolucion,num_prueba,distancia_focal,estilo)

                        % Guardamos el campo de referencia y el vector espacial
                        % save(fullfile(ruta,'Campo en el plano de Fourier'),'I_ref')
                        % save(fullfile(ruta,'Vector x'),'x')
                         
                        % -----------------------------------------------------
                        % Correlación con respecto al plano de Fourier
                        % -----------------------------------------------------

                        % Calculamos la correlación cruzada con respecto al plano de Fourier

                        % Recorremos todos los planos almacenados entre la lente y el plano de Fourier
                        for l = posicion_de_la_lente:(posicion_del_plano_de_Fourier-1)

                            % Recuperamos la irradiancia del plano correspondiente
                            I2 = Irradiancias(:,:,l-posicion_de_la_lente+1);

                            % Normalizamos la irradiancia
                            I2 = I2/sum(I2(:));

                            % Calculamos la correlación de Pearson entre
                            % la irradiancia actual y la irradiancia de referencia
                            pearson(l-posicion_de_la_lente+1) = corr2(I_ref_norm,I2);

                        end

                        % La correlación del plano de Fourier consigo mismo es 1
                        pearson(posicion_del_plano_de_Fourier-posicion_de_la_lente+1) = 1;

                    % ---------------------------------------------------------
                    % Planos posteriores al plano de Fourier
                    % ---------------------------------------------------------
                    elseif g > posicion_del_plano_de_Fourier

                        % Normalizamos la irradiancia actual
                        I2 = I2/sum(I2(:));

                        % Calculamos la correlación con respecto a la irradiancia del plano de Fourier
                        pearson(g-posicion_de_la_lente+1) = corr2(I_ref_norm,I2);

                    end

                    % ---------------------------------------------------------
                    % Aplicación de la lente
                    % ---------------------------------------------------------

                    if g == posicion_de_la_lente
                        
                        % Al llegar a la posición de la lente, multiplicamos
                        % el campo propagado por la función de transmitancia
                        % de la lente.
                        u1 = u2.*lente(x,distancia_focal,k,r_pupila);

                    else
                        
                        % En los demás planos, simplemente actualizamos el
                        % campo que será propagado en el siguiente paso
                        u1 = u2;

                    end

                end

                % Mostramos en pantalla el progreso de la simulación
                disp(['Frame ',num2str(g),'/',num2str(length(vector_z)),' completado.'])
            
            end
            
        end

        % Cerramos el archivo de video
        close(video);

        % ---------------------------------------------------------------------
        % Código alternativo para generar una representación transversal
        % ---------------------------------------------------------------------
        % Este bloque está desactivado. Permitiría realizar una propagación
        % transversal y construir una gráfica de irradiancia en función de
        % z y x.
        
        % while (propagacion == 2) && (g == 1)
        %     I1 = abs(u1).^2;        % Irradiancia [U.A.] del campo u1
        %     I1 = I1/max(I1(:));
        % 
        %     figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);
        %     imagesc(x,x,I1);
        %     set(gca,'YDir','normal') 
        %     title(['Frame ',num2str(g-1),' (z = 0 cm)']);
        %     xlabel('Eje x [cm]');
        %     ylabel('Eje y [cm]');
        %     set(gca,'FontSize',35)
        %     axis equal
        %     axis tight
        %     cb = colorbar;
        %     colormap(gca, estilo)
        %     ylabel(cb,'Irradiancia [U.A.]')
        % 
        %     I = zeros(length(u1),1);
        %     I(:,1) = I1(ordenada,:)';
        % 
        %     for g = 2:length(vector_z)
        %         u2 = propTF(u1,L,lambda,vector_z(g));
        %         I2 = abs(u2).^2;
        %         I2 = I2/max(I2(:));
        %         I = [I,I2(ordenada,:)'];
        % 
        %         if g == (length(vector_z)+1)/2
        %             u1 = u2.*lente(x,distancia_focal,k,r_pupila); % Actualizamos el campo que estamos propagando (multiplicamos por la función de transmitancia de la lente)
        %         else
        %             u1 = u2; % Actualizamos el campo que estamos propagando
        %         end
        %     end
        % 
        %     figure('Visible',"on","Units", 'normalized', 'Position', [0, 0, 1, 1]);    
        %     imagesc(vector_z,x,I);
        %     set(gca,'YDir','normal') 
        %     title(['Propagación hasta una distanica de ',num2str(z_max),' cm (y = ',num2str(x(ordenada)),' cm)']);
        %     xlabel('Eje z [cm]');
        %     ylabel('Eje x [cm]');
        %     set(gca,'FontSize',25)
        %     colormap(gca, estilo)
        %     cb = colorbar;   
        %     ylabel(cb,'Irradiancia [U.A.]')
        % 
        %     g = g+1;
        % end
   
        % ---------------------------------------------------------------------
        % Análisis posterior a la propagación
        % ---------------------------------------------------------------------
   
        disp(' ')
        disp('Generando gráficos auxiliares...')

        % Generamos la gráfica de comprobación de la validéz de la propagación.
        % graficos_comprobacion(resolucion,z_R,filename_0,num_prueba,vector_z,comprobacion);

        % Generamos las gráficas de los campos ópticos en el plano de la lente y
        % en z=3f.
        graficos_lente_3f(resolucion,lambda,filename_13,estilo,I_lente,filename_14,I_3f,num_prueba,x)

        % Realizamos el análisis de las imágenes obtenidas mediante un filtro
        % pasa bandas basado en una diferencia de gaussianas (DoG).
        filtro_DoG(lambda,x,I_ref,ruta,calidad_de_video,num_prueba);

        % Generamos las gráficas de los campos ópticos en el plano fuente y
        % de observación.
        graficos_campos(resolucion,radio_exterior,lambda,filename_12,estilo,I1,filename_11,I_ref,num_prueba,x);

        % Generamos la gráfica de la evolución de la potencia durante la
        % propagación y calculamos su valor promedio.
        [promedio_de_potencia] = graficos_potencia(resolucion,distancia_focal,filename_1,num_prueba,vector_z,Potencia);

        % Generamos la gráfica de la evolución del coeficiente de correlación
        % durante la propagación y calculamos su valor promedio.
        [promedio_de_pearson] = graficos_pearson(resolucion,distancia_focal,filename_2,num_prueba,vector_z,pearson,posicion_de_la_lente);

        % Calculamos la autocorrelación bidimensional de la distribución de
        % irradiancia normalizada y obtenemos los radios y anchos asociados
        % a los niveles de autocorrelación de 0.25, 0.50 y 0.75.
        [r_0,r_1,r_2,ordenadas,FWC25,FWC50,FWC75,autopearson,idx_1,idx_2] = calculo_autocorrelaciones(I_ref_norm,x);

        % Generamos y guardamos las gráficas de la autocorrelación, indicando
        % los radios y anchos característicos obtenidos para los niveles de
        % autocorrelación de 0.25, 0.50 y 0.75.
        graficos_autocorrelaciones(idx_1,idx_2,autopearson,r_0,r_1,r_2,ordenadas,FWC25,FWC50,FWC75,estilo,lambda,filename_3_0,filename_3_1,filename_3_2,filename_3_3,num_prueba,resolucion,x);

        % Detenemos el cronómetro y obtenemos el tiempo total de ejecución
        tiempo = toc;
    
        disp(' ')
        disp('Generando archivos de parámetros de propagación...')
        
        % Guardamos los parámetros y resultados en un archivo TXT
        [lambda, distancia_focal, L, M, paso_z, dx, num_granos, ...
            size_grano_del_difusor_x, size_grano_del_difusor_y, R_0, grosor, ...
            amplitud, ang_mayor, ang_menor, FWC50, FWC75, FWC25, tiempo] = archivo_txt(promedio_de_potencia,promedio_de_pearson,size_grano_del_difusor_x,size_grano_del_difusor_y,filename_5,num_prueba,lambda,distancia_focal,L,M,paso_z,dx,num_granos,R_0,grosor,amplitud,ang_mayor,ang_menor,FWC50,FWC75,FWC25,tiempo);

        % Guardamos los parámetros y resultados en un archivo CSV
        archivo_csv(promedio_de_potencia,promedio_de_pearson,size_grano_del_difusor_x,size_grano_del_difusor_y,filename_6,num_prueba,lambda,distancia_focal,L,M,paso_z,dx,num_granos,R_0,grosor,amplitud,ang_mayor,ang_menor,FWC50,FWC75,FWC25,tiempo);

        disp(' ')
    
        % ---------------------------------------------------------------------
        % Código desactivado para verificar los criterios de muestreo
        % ---------------------------------------------------------------------
        
        % if propagacion == 1
        % 
        %     if g == length(vector_z) 
        % 
        %         disp('Listo, simulación exitosa.')
        % 
        %     elseif g == 1
        % 
        %         disp('Verificar la condición \delta x > \lambda * z / L')
        % 
        %     else
        % 
        %         disp(['Listo. Se dejaron de satisfacer los criterios de muestreo y el programa se detuvo en el frame ',num2str(g-2)])
        % 
        %     end
        % 
        % end
        
        % Indicamos que la simulación terminó correctamente
        disp(['Simulación ',num2str(num_prueba),'/',num2str(numero_de_simulaciones),' exitosa.'])
        disp(' ')

    else
        
        % Si no se cumplen las condiciones de propagación, se reproduce un
        % sonido indicando que ocurrió un error
        sonido_de_falla

        disp(' ')
        disp('¡ERROR!')
        disp(' ')
        disp('No se han satisfecho los criterios de muestreo.')
        disp(' ')
        disp('Verifica los parámetros de propagación.')

        % Marcamos la simulación como no válida
        validez = 0;
    
    end
end

% -------------------------------------------------------------------------
% Análisis final de todas las simulaciones
% -------------------------------------------------------------------------

% Si todas las simulaciones fueron consideradas válidas
if validez == 1

    disp('Generando gráficos comparativos...')
    
    if num_prueba ~= 1

        % Hacemos videos comparativos de los resultados numéricos de todas las simulaciones
        videos_comparativos(ruta_base,ruta_de_carpeta_de_simulaciones,numero_de_simulaciones)
    
        % Generamos las gráficas comparativas de FWC_q, potencia y coeficiente de correlación promedio y tiempo de ejecución
        graficos_comparativos(filename_9,filename_10,filename_8,resolucion,filename_7_g,filename_7_s,filename_7_l,numero_de_simulaciones,ruta_de_carpeta_de_simulaciones)
        
    end

    % Calculamos el tiempo total de ejecución de todo el programa.
    tiempo_total = toc(tic_total);
    
    disp(' ')
    
    % Mostramos un mensaje indicando que la simulación terminó.
    disp('¡LISTO!')
    
    disp(' ')
    
    % Mostramos el tiempo total de cómputo en minutos.
    disp(['Tiempo de cómputo: ',num2str(tiempo_total/60),' min.'])
        
    % Reproduce el sonido indicando que todas las simulaciones terminaron
    terminado

end