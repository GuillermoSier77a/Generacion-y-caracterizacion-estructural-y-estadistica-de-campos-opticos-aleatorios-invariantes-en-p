function filtro_DoG(R_0,x,I_ref,ruta,calidad_de_video,num_prueba)

    % Las siguientes líneas permiten cargar manualmente la distribución de
    % irradiancia en el plano imagen y el vector de coordenadas espaciales
    % a partir de archivos previamente almacenados.
    % filename_1 = fullfile(ruta_de_carpeta_de_simulaciones,'Simulación 1/Campo en el plano imagen.mat');
    % filename_2 = fullfile(ruta_de_carpeta_de_simulaciones,'Simulación 1/Vector x.mat');
    % 
    % datos_1 = load(filename_1);
    % datos_2 = load(filename_2);
    
    % I_ref = datos_1.I_ref;
    % x = datos_2.x;

    % Convertimos la distribución de irradiancia de referencia a precisión
    % simple para reducir el uso de memoria durante el procesamiento.
    I_ref = single(I_ref);
    
    % Definimos el número de configuraciones del filtro DoG que serán
    % evaluadas y la tasa de cuadros de los videos generados.
    num_frames = 15;
    frame_rate = 5;

    % Definimos el número de niveles empleados para construir el mapa de
    % colores divergente utilizado para representar la respuesta del filtro.
    n = 256;

    % Construimos la primera mitad del mapa de colores, correspondiente a
    % una transición de azul a blanco.
    azul_blanco = [linspace(0,1,n/2)',linspace(0,1,n/2)',ones(n/2,1)];

    % Construimos la segunda mitad del mapa de colores, correspondiente a
    % una transición de blanco a rojo.
    blanco_rojo = [ones(n/2,1),linspace(1,0,n/2)',linspace(1,0,n/2)'];

    % Concatenamos ambas regiones para obtener un mapa de colores divergente
    % azul-blanco-rojo, adecuado para distinguir respuestas negativas y
    % positivas del filtro DoG.
    cmap = [azul_blanco; blanco_rojo];

    % Definimos las rutas de los dos videos que almacenarán los resultados
    % del filtrado DoG.
    video_filename_1 = fullfile(ruta,'Filtro DoG.mp4');
    video_filename_2 = fullfile(ruta,'Filtro DoG dividido.mp4');

    % Creamos el primer video, destinado a mostrar la respuesta completa
    % del filtro DoG para cada combinación de sigma_1 y sigma_2.
    video_1 = VideoWriter(video_filename_1,'MPEG-4');
    video_1.FrameRate = frame_rate;
    video_1.Quality = calidad_de_video;
    open(video_1);

    % Creamos el segundo video, destinado a mostrar por separado las
    % componentes positiva y negativa de la respuesta del filtro DoG.
    video_2 = VideoWriter(video_filename_2,'MPEG-4');
    video_2.FrameRate = frame_rate;
    video_2.Quality = calidad_de_video;
    open(video_2);

    % Creamos una figura no visible para representar la respuesta completa
    % del filtro DoG y generar los cuadros del primer video.
    fig_1 = figure('Visible',"off",'Units','pixels','Position',[100 100 800 800]);

    % Creamos los ejes asociados a la primera figura.
    ax1 = axes(fig_1);

    % Inicializamos la imagen con una matriz de ceros y expresamos las
    % coordenadas espaciales normalizadas con respecto al radio R_0.
    h1 = imagesc(ax1,x/R_0,x/R_0,zeros(size(I_ref)));

    % Etiquetamos los ejes espaciales normalizados.
    xlabel(ax1,'Eje x [R_0]','FontWeight','bold');
    ylabel(ax1,'Eje y [R_0]','FontWeight','bold');

    % Agregamos la barra de color correspondiente a la respuesta del filtro.
    cb1 = colorbar(ax1);
    ylabel(cb1,'Respuesta del filtro','FontWeight','bold');

    % Aplicamos el mapa de colores divergente azul-blanco-rojo.
    colormap(ax1,cmap);

    % Ajustamos la orientación y el formato de los ejes.
    set(ax1,'YDir','normal');
    set(ax1,'FontSize',15,'FontWeight','bold');

    % Conservamos la misma escala en ambos ejes y ajustamos sus límites
    % al dominio espacial representado.
    axis(ax1,'equal');
    axis(ax1,'tight');

    % Creamos una segunda figura no visible con dos paneles para representar
    % por separado las respuestas positiva y negativa del filtro DoG.
    fig_2 = figure('Visible',"off",'Units','pixels','Position',[100 100 1600 800]);

    % Dividimos la segunda figura horizontalmente en dos regiones.
    tiledlayout(fig_2,1,2,'TileSpacing','compact','Padding','compact');

    % Creamos el primer panel, destinado a representar la componente
    % positiva de la respuesta del filtro DoG.
    ax2 = nexttile;
    h2 = imagesc(ax2,x/R_0,x/R_0,zeros(size(I_ref)));

    % Etiquetamos los ejes espaciales normalizados.
    xlabel(ax2,'Eje x [R_0]','FontWeight','bold');
    ylabel(ax2,'Eje y [R_0]','FontWeight','bold');

    % Agregamos la barra de color correspondiente a la respuesta del filtro.
    cb2 = colorbar(ax2);
    ylabel(cb2,'Respuesta del filtro','FontWeight','bold');

    % Aplicamos el mapa de colores divergente.
    colormap(ax2,cmap);

    % Ajustamos la orientación y el formato de los ejes.
    set(ax2,'YDir','normal');
    set(ax2,'FontSize',15,'FontWeight','bold');

    % Conservamos la misma escala espacial en ambos ejes.
    axis(ax2,'equal');
    axis(ax2,'tight');


    % Creamos el segundo panel, destinado a representar la componente
    % negativa de la respuesta del filtro DoG.
    ax3 = nexttile;
    h3 = imagesc(ax3,x/R_0,x/R_0,zeros(size(I_ref)));

    % Etiquetamos los ejes espaciales normalizados.
    xlabel(ax3,'Eje x [R_0]','FontWeight','bold');
    ylabel(ax3,'Eje y [R_0]','FontWeight','bold');

    % Agregamos la barra de color correspondiente a la respuesta del filtro.
    cb3 = colorbar(ax3);
    ylabel(cb3,'Respuesta del filtro','FontWeight','bold');

    % Aplicamos el mapa de colores divergente.
    colormap(ax3,cmap);

    % Ajustamos la orientación y el formato de los ejes.
    set(ax3,'YDir','normal');
    set(ax3,'FontSize',15,'FontWeight','bold');

    % Conservamos la misma escala espacial en ambos ejes.
    axis(ax3,'equal');
    axis(ax3,'tight');

    % Recorremos las diferentes escalas espaciales utilizadas para construir
    % el filtro DoG y generamos un cuadro de video para cada configuración.
    for i = 1:num_frames

        % Definimos las desviaciones estándar de los dos filtros gaussianos,
        % manteniendo la relación sigma_2 = 2*sigma_1.
        sigma1 = 0.5*i;
        sigma2 = 2*sigma1;

        % Suavizamos la distribución de irradiancia mediante dos filtros
        % gaussianos caracterizados por sigma_1 y sigma_2.
        I1 = imgaussfilt(I_ref,sigma1);
        I2 = imgaussfilt(I_ref,sigma2);

        % Calculamos la diferencia de gaussianas (DoG), que actúa como un
        % filtro pasa bandas espacial al sustraer las dos versiones
        % suavizadas de la distribución de irradiancia.
        DoG = I1 - I2;

        % Separamos las respuestas positiva y negativa del filtro DoG para
        % analizar individualmente ambas contribuciones.
        positivo = max(DoG,0);
        negativo = min(DoG,0);

        % Actualizamos la imagen de la primera figura con la respuesta
        % completa del filtro DoG.
        h1.CData = DoG;

        % Calculamos un límite de visualización a partir del percentil 99.5
        % del valor absoluto de la respuesta, reduciendo la influencia de
        % valores extremos sobre la escala de color.
        M = prctile(abs(DoG(:)),99.5);

        % Establecemos límites simétricos alrededor de cero para representar
        % de manera comparable las respuestas positivas y negativas.
        clim(ax1,[-M M]);

        % Indicamos en el título el número de simulación y los valores de
        % sigma_1 y sigma_2 utilizados en la configuración actual.
        title(ax1,sprintf('Simulación %g (\\sigma_1 = %g, \\sigma_2 = %g)',num_prueba,sigma1,sigma2),'FontWeight','bold');

        % Actualizamos la figura antes de capturar el cuadro correspondiente.
        drawnow limitrate;

        % Capturamos la figura y agregamos el cuadro al primer video.
        frame_1 = getframe(fig_1);
        writeVideo(video_1,frame_1);

        % Actualizamos los dos paneles de la segunda figura con las
        % componentes positiva y negativa de la respuesta del filtro.
        h2.CData = positivo;
        h3.CData = negativo;

        % Calculamos de manera independiente los límites de visualización
        % para las componentes positiva y negativa mediante el percentil 99.5.
        M_pos = prctile(abs(positivo(:)),99.5);
        M_neg = prctile(abs(negativo(:)),99.5);

        % Ajustamos las escalas de color de ambos paneles de acuerdo con
        % las amplitudes de las respectivas componentes.
        clim(ax2,[-M_pos M_pos]);
        clim(ax3,[-M_neg M_neg]);

        % Indicamos los parámetros del filtro utilizados en el panel
        % correspondiente a la respuesta positiva.
        title(ax2,sprintf('Simulación %g (\\sigma_1 = %g, \\sigma_2 = %g)',num_prueba,sigma1,sigma2),'FontWeight','bold');

        % Indicamos los mismos parámetros en el panel correspondiente a la
        % respuesta negativa.
        title(ax3,sprintf('Simulación %g (\\sigma_1 = %g, \\sigma_2 = %g)',num_prueba,sigma1,sigma2),'FontWeight','bold');

        % Actualizamos la segunda figura antes de capturar el cuadro.
        drawnow limitrate;

        % Capturamos ambos paneles y agregamos el cuadro al segundo video.
        frame_2 = getframe(fig_2);
        writeVideo(video_2,frame_2);

    end

    % Cerramos ambos archivos de video una vez procesadas todas las
    % configuraciones del filtro DoG.
    close(video_1);
    close(video_2);

    % Cerramos las figuras auxiliares utilizadas para generar los videos.
    close(fig_1);
    close(fig_2);

end