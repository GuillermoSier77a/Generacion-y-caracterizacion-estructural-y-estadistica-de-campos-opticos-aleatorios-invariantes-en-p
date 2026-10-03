function videos_comparativos(ruta_base,ruta_de_carpeta_de_simulaciones,num_pruebas)
    
    % Se generan videos comparativos a partir de las figuras obtenidas en
    % cada simulación. Cada cuadro corresponde a una simulación diferente,
    % lo que permite visualizar la evolución de distintas magnitudes y
    % características del campo al variar los parámetros estudiados.

    %----------------------------------------------------------------------
    % Video 0: Comparación de invariancias.mp4
    %----------------------------------------------------------------------
    
    % Se crea el video destinado a comparar la evolución del coeficiente
    % de correlación correspondiente a las diferentes simulaciones.
    video0 = VideoWriter(fullfile(ruta_base,'Comparación de evolución de invariancias.mp4'),'MPEG-4');

    % Se establece una tasa de reproducción de cinco cuadros por segundo.
    video0.FrameRate = 5;

    % Se abre el archivo de video para comenzar la escritura.
    open(video0)
    
    %----------------------------------------------------------------------
    % Video 1: Comparación de evolución de potencias.mp4
    %----------------------------------------------------------------------
    
    % Se crea el video destinado a comparar la evolución de la potencia
    % óptica correspondiente a las diferentes simulaciones.
    video1 = VideoWriter(fullfile(ruta_base,'Comparación de evolución de potencias.mp4'),'MPEG-4');

    % Se establece una tasa de reproducción de cinco cuadros por segundo.
    video1.FrameRate = 5;

    % Se abre el archivo de video para comenzar la escritura.
    open(video1)
    
    %----------------------------------------------------------------------
    % Video 2: Comparación de perfiles de autocorrelación 0-1.mp4
    %----------------------------------------------------------------------
    
    % Se crea el video destinado a comparar los perfiles completos de
    % autocorrelación obtenidos en las diferentes simulaciones.
    video2 = VideoWriter(fullfile(ruta_base,'Comparación de perfiles de autocorrelación 0-1.mp4'),'MPEG-4');

    % Se establece una tasa de reproducción de cinco cuadros por segundo.
    video2.FrameRate = 5;

    % Se abre el archivo de video para comenzar la escritura.
    open(video2)
    
    %----------------------------------------------------------------------
    % Video 3: Comparación de campos en el plano fuente y de Fourier.mp4
    %----------------------------------------------------------------------
    
    % Se crea el video destinado a comparar simultáneamente las
    % distribuciones de irradiancia en el plano fuente y en el plano de
    % Fourier correspondientes a cada simulación.
    video3 = VideoWriter(fullfile(ruta_base,'Comparación de campos en el plano fuente y de Fourier.mp4'),'MPEG-4');

    % Se establece una tasa de reproducción de cinco cuadros por segundo.
    video3.FrameRate = 5;

    % Se abre el archivo de video para comenzar la escritura.
    open(video3)

    %----------------------------------------------------------------------
    % Video 4: Comparación de perfiles de autocorrelación 0.50-1.mp4
    %----------------------------------------------------------------------

    % Se crea el video destinado a comparar la región de los perfiles de
    % autocorrelación comprendida entre los niveles 0.50 y 1.
    video4 = VideoWriter(fullfile(ruta_base,'Comparación de perfiles de autocorrelación 0.50-1.mp4'),'MPEG-4');

    % Se establece una tasa de reproducción de cinco cuadros por segundo.
    video4.FrameRate = 5;

    % Se abre el archivo de video para comenzar la escritura.
    open(video4)

    %----------------------------------------------------------------------
    % Video 5: Comparación de perfiles de autocorrelación 0-0.50.mp4
    %----------------------------------------------------------------------

    % Se crea el video destinado a comparar la región de los perfiles de
    % autocorrelación comprendida entre los niveles 0 y 0.50.
    video5 = VideoWriter(fullfile(ruta_base,'Comparación de perfiles de autocorrelación 0-0.50.mp4'),'MPEG-4');

    % Se establece una tasa de reproducción de cinco cuadros por segundo.
    video5.FrameRate = 5;

    % Se abre el archivo de video para comenzar la escritura.
    open(video5)

    %----------------------------------------------------------------------
    % Video 6: Comparación de anillos de autocorrelaciones.mp4
    %----------------------------------------------------------------------

    % Se crea el video destinado a comparar las representaciones de los
    % anillos asociados a los diferentes niveles de autocorrelación.
    video6 = VideoWriter(fullfile(ruta_base,'Comparación de anillos de autocorrelaciones.mp4'),'MPEG-4');

    % Se establece una tasa de reproducción de cinco cuadros por segundo.
    video6.FrameRate = 5;

    % Se abre el archivo de video para comenzar la escritura.
    open(video6)
    
    % Se recorren secuencialmente las carpetas correspondientes a cada una
    % de las simulaciones realizadas.
    for i = 1:num_pruebas
    
        % Se construye la ruta de la carpeta correspondiente a la simulación
        % actual.
        carpeta = fullfile(ruta_de_carpeta_de_simulaciones,sprintf('Simulación %d',i));
    
        % Saltar si la carpeta no existe

        % Se verifica la existencia de la carpeta antes de intentar acceder
        % a las figuras almacenadas. Si no existe, se genera una advertencia
        % y se continúa con la siguiente simulación.
        if ~isfolder(carpeta)
            warning('No existe %s',carpeta)
            continue
        end
    
        %==================================================================
        % Video 0: Comparación de invariancias.mp4
        %==================================================================
    
        % Se carga la gráfica correspondiente a la evolución del coeficiente
        % de correlación de la simulación actual.
        img1 = imread(fullfile(carpeta,'Evolución de la invariancia.png'));
    
        % Se obtienen las dimensiones espaciales de la imagen.
        h = max(size(img1,1));
        w = max(size(img1,2));
    
        % Se ajusta la imagen a las dimensiones obtenidas para generar el
        % cuadro correspondiente.
        frame0 = imresize(img1,[h w]);
        
        % Para la primera simulación se establecen las dimensiones de
        % referencia del video. Los cuadros posteriores se ajustan a estas
        % dimensiones para mantener un tamaño constante.
        if i == 1
            [alto0,ancho0,~] = size(frame0);
        else
            frame0 = imresize(frame0,[alto0 ancho0]);
        end
    
        % Se garantiza que las dimensiones del cuadro sean pares antes de
        % incorporarlo al archivo de video.
        frame0 = hacer_dimensiones_pares(frame0);

        % Se agrega el cuadro correspondiente a la simulación actual.
        writeVideo(video0,frame0);
        
        %==================================================================
        % Video 1: Comparación de evolución de potencias.mp4
        %==================================================================
    
        % Se carga la gráfica correspondiente a la evolución de la potencia
        % óptica de la simulación actual.
        img2 = imread(fullfile(carpeta,'Evolución de la potencia óptica.png'));
    
        % Se obtienen las dimensiones espaciales de la imagen.
        h = max(size(img2,1));
        w = max(size(img2,2));
    
        % Se ajusta la imagen a las dimensiones obtenidas para generar el
        % cuadro correspondiente.
        frame1 = imresize(img2,[h w]);
        
        % Para la primera simulación se establecen las dimensiones de
        % referencia. Los cuadros posteriores se ajustan al mismo tamaño.
        if i == 1
            [alto1,ancho1,~] = size(frame1);
        else
            frame1 = imresize(frame1,[alto1 ancho1]);
        end
    
        % Se garantiza que las dimensiones del cuadro sean pares y se
        % incorpora el resultado al video correspondiente.
        frame1 = hacer_dimensiones_pares(frame1);
        writeVideo(video1,frame1);
    
        %==================================================================
        % Video 2: Comparación de perfiles de autocorrelación 0-1.mp4
        %==================================================================
    
        % Se carga la gráfica correspondiente al perfil completo de
        % autocorrelación de la simulación actual.
        img3 = imread(fullfile(carpeta,'Perfil de autocorrelación 0-1.png'));

        % Se obtienen las dimensiones espaciales de la imagen.
        h = max(size(img3,1));
        w = max(size(img3,2));

        % Se ajusta la imagen a las dimensiones obtenidas para generar el
        % cuadro correspondiente.
        frame2 = imresize(img3,[h w]);

        % Para la primera simulación se establecen las dimensiones de
        % referencia. Los cuadros posteriores se ajustan al mismo tamaño.
        if i == 1
            [alto2,ancho2,~] = size(frame2);
        else
            frame2 = imresize(frame2,[alto2 ancho2]);
        end
    
        % Se garantiza que las dimensiones del cuadro sean pares y se
        % incorpora el resultado al video correspondiente.
        frame2 = hacer_dimensiones_pares(frame2);
        writeVideo(video2,frame2);

        %==================================================================
        % Video 3: Comparación de campos en el plano fuente y de Fourier.mp4
        %==================================================================
    
        % Se cargan las distribuciones de irradiancia correspondientes al
        % campo inicial y al campo obtenido en el plano de Fourier.
        img6 = imread(fullfile(carpeta,'Campo inicial.png'));
        img7 = imread(fullfile(carpeta,'Campo en el plano de Fourier.png'));
    
        % Se determina la mayor altura entre ambas imágenes para establecer
        % una dimensión vertical común.
        h = max(size(img6,1),size(img7,1));

        % Se ajustan ambas imágenes a la misma altura conservando sus
        % respectivas relaciones de aspecto.
        img6 = imresize(img6,[h NaN]);
        img7 = imresize(img7,[h NaN]);
        
        % Se concatenan horizontalmente las imágenes del plano fuente y del
        % plano de Fourier para generar un único cuadro comparativo.
        frame3 = [img6 img7];
    
        % Para la primera simulación se establecen las dimensiones de
        % referencia. Los cuadros posteriores se ajustan al mismo tamaño.
        if i == 1
            [alto3,ancho3,~] = size(frame3);
        else
            frame3 = imresize(frame3,[alto3 ancho3]);
        end
    
        % Se garantiza que las dimensiones del cuadro sean pares y se
        % incorpora la comparación de ambos campos al video.
        frame3 = hacer_dimensiones_pares(frame3);
        writeVideo(video3,frame3);
         
        %==================================================================
        % Video 4: Comparación de perfiles de autocorrelación 0.50-1.mp4
        %==================================================================

        % Se carga la gráfica correspondiente a la región del perfil de
        % autocorrelación comprendida entre los niveles 0.50 y 1.
        img4 = imread(fullfile(carpeta,'Perfil de autocorrelación 0.50-1.png'));
       
        % Se obtienen las dimensiones espaciales de la imagen.
        h = max(size(img4,1));
        w = max(size(img4,2));

        % Se ajusta la imagen a las dimensiones obtenidas para generar el
        % cuadro correspondiente.
        frame4 = imresize(img4,[h w]);
    
        % Para la primera simulación se establecen las dimensiones de
        % referencia. Los cuadros posteriores se ajustan al mismo tamaño.
        if i == 1
            [alto4,ancho4,~] = size(frame4);
        else
            frame4 = imresize(frame4,[alto4 ancho4]);
        end
    
        % Se garantiza que las dimensiones del cuadro sean pares y se
        % incorpora el resultado al video correspondiente.
        frame4 = hacer_dimensiones_pares(frame4);
        writeVideo(video4,frame4);

        %==================================================================
        % Video 5: Comparación de perfiles de autocorrelación 0-0.50.mp4
        %==================================================================

        % Se carga la gráfica correspondiente a la región del perfil de
        % autocorrelación comprendida entre los niveles 0 y 0.50.
        img5 = imread(fullfile(carpeta,'Perfil de autocorrelación 0-0.50.png'));
        
        % Se obtienen las dimensiones espaciales de la imagen.
        h = max(size(img5,1));
        w = max(size(img5,2));

        % Se ajusta la imagen a las dimensiones obtenidas para generar el
        % cuadro correspondiente.
        frame5 = imresize(img5,[h w]);
    
        % Para la primera simulación se establecen las dimensiones de
        % referencia. Los cuadros posteriores se ajustan al mismo tamaño.
        if i == 1
            [alto5,ancho5,~] = size(frame5);
        else
            frame5 = imresize(frame5,[alto5 ancho5]);
        end
    
        % Se garantiza que las dimensiones del cuadro sean pares y se
        % incorpora el resultado al video correspondiente.
        frame5 = hacer_dimensiones_pares(frame5);
        writeVideo(video5,frame5);

        %==================================================================
        % Video 6: Comparación de anillos de autocorrelaciones.mp4
        %==================================================================

        % Se carga la representación de los anillos correspondientes a los
        % diferentes niveles de autocorrelación de la simulación actual.
        img6 = imread(fullfile(carpeta,'Anillos de autocorrelación.png'));

        % Se obtienen las dimensiones espaciales de la imagen.
        h = max(size(img6,1));
        w = max(size(img6,2));

        % Se ajusta la imagen a las dimensiones obtenidas para generar el
        % cuadro correspondiente.
        frame6 = imresize(img6,[h w]);

        % Para la primera simulación se establecen las dimensiones de
        % referencia. Los cuadros posteriores se ajustan al mismo tamaño.
        if i == 1
            [alto6,ancho6,~] = size(frame6);
        else
            frame6 = imresize(frame6,[alto6 ancho6]);
        end

        % Se garantiza que las dimensiones del cuadro sean pares y se
        % incorpora el resultado al video correspondiente.
        frame6 = hacer_dimensiones_pares(frame6);
        writeVideo(video6,frame6);
    
    end
    
    % Se cierran los archivos de video una vez procesadas todas las
    % simulaciones, finalizando correctamente su escritura.
    close(video0)
    close(video1)
    close(video2)
    close(video3)
    close(video4)
    close(video5)
    close(video6)

end