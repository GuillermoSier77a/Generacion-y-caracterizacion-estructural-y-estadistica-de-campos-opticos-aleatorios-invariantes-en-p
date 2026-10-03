function graficos_autocorrelaciones(idx_1,idx_2,autocorrelacion,r_0,r_1,r_2,ordenadas,FWC25,FWC50,FWC75,estilo,lambda,filename_3_0,filename_3_1,filename_3_2,filename_3_3,num_prueba,resolucion,x)

    % Definimos el color verde utilizado para representar el nivel de
    % autocorrelación correspondiente al 50 % de su valor máximo.
    verde    = [0.0000 0.6000 0.2500];

    % Creamos una figura no visible para representar tridimensionalmente
    % la autocorrelación normalizada.
    fig_3_0 = figure('Visible','off',"Units", 'normalized', 'Position', [0, 0, 1, 1]);

    % Representamos la autocorrelación como una superficie tridimensional
    % utilizando coordenadas espaciales normalizadas respecto a R_0.
    surf(x/lambda,x/lambda,autocorrelacion);

    % Suavizamos visualmente la superficie mediante interpolación de colores.
    shading interp;

    % Conservamos la gráfica actual para superponer los círculos asociados
    % a los diferentes niveles de la autocorrelación.
    hold on

    % Generamos un vector angular para construir los círculos que representan
    % los anchos de la autocorrelación a los niveles 0.25, 0.50 y 0.75.
    theta = linspace(0,2*pi,500);

    % Las siguientes instrucciones permiten representar puntos y contornos
    % asociados a los diferentes niveles de la autocorrelación.
    % plot3(x(columna_0),x(fila_0),0.25,'Color','k','MarkerSize',45);
    % plot3(x(columna_1),x(fila_1),0.50,'Color','k','MarkerSize',45);
    % plot3(x(columna_2),x(fila_2),0.75,'Color','k','MarkerSize',45);
    % contour3(x,x,autocorrelacion,[0.25 0.25],'Color',dorado,'LineWidth',5);
    % contour3(x,x,autocorrelacion,[0.50 0.50],'Color',morado,'LineWidth',5);
    % contour3(x,x,autocorrelacion,[0.75 0.75],'Color',turquesa,'LineWidth',5);

    % Representamos el círculo correspondiente al nivel 0.25 de la
    % autocorrelación, con radio r_0 normalizado respecto a R_0.
    h_0 = plot3(r_0/lambda*cos(theta),r_0/lambda*sin(theta),0.25*ones(size(theta)),'b','LineWidth',3,'DisplayName',sprintf('FWC_{0.25} = %0.4e λ',FWC25/lambda),'LineStyle','-');

    % Representamos el círculo correspondiente al nivel 0.50 de la
    % autocorrelación, con radio r_1 normalizado respecto a R_0.
    h_1 = plot3(r_1/lambda*cos(theta),r_1/lambda*sin(theta),0.50*ones(size(theta)),'Color',verde,'LineWidth',3,'DisplayName',sprintf('FWC_{0.50} = %0.4e λ',FWC50/lambda),'LineStyle','-');

    % Representamos el círculo correspondiente al nivel 0.75 de la
    % autocorrelación, con radio r_2 normalizado respecto a R_0.
    h_2 = plot3(r_2/lambda*cos(theta),r_2/lambda*sin(theta),0.75*ones(size(theta)),'r','LineWidth',3,'DisplayName',sprintf('FWC_{0.75} = %0.4e λ',FWC75/lambda),'LineStyle','-');

    % Orientamos el eje vertical de manera que sus valores aumenten de
    % abajo hacia arriba.
    set(gca,'YDir','normal') 

    % Indicamos en el título el número correspondiente a la simulación.
    title(['Simulación ',num2str(num_prueba)],'FontWeight','bold');

    % Etiquetamos los ejes espaciales normalizados y el valor de la
    % autocorrelación.
    xlabel('Eje x [λ]','FontWeight','bold');
    ylabel('Eje y [λ]','FontWeight','bold');
    zlabel('C [U.A.]','FontWeight','bold');

    % Configuramos el tamaño y el grosor de la fuente de los ejes.
    set(gca,'FontSize',15,'FontWeight','bold')

    % Ajustamos los límites de los ejes al intervalo de los datos mostrados.
    axis tight

    % Las siguientes instrucciones permiten restringir la región espacial
    % mostrada utilizando el radio correspondiente al nivel 0.25.
    % xlim([-r_0 r_0])
    % ylim([-r_0 r_0])

    % Establecemos el ángulo de observación de la superficie tridimensional.
    view(50,10);

    % Agregamos una barra de color para indicar los valores de la
    % autocorrelación.
    cb = colorbar;

    % Aplicamos el mapa de colores seleccionado para la simulación.
    colormap(gca, estilo)

    % Etiquetamos la barra de color.
    ylabel(cb,'C [U.A.]','FontWeight','bold')

    % Generamos la leyenda de los círculos correspondientes a los niveles
    % 0.75, 0.50 y 0.25 de la autocorrelación.
    legend([h_2 h_1 h_0],'Location','best')

    % Exportamos la representación tridimensional de la autocorrelación
    % utilizando la resolución especificada.
    exportgraphics(fig_3_0,filename_3_0,'Resolution',resolucion);

    % La siguiente instrucción permite cerrar la figura después de
    % exportarla.
    % close(fig_3_0)
   
    % Creamos una segunda figura no visible para representar el corte
    % horizontal central de la autocorrelación.
    fig_3_1 = figure('Visible',"off","Units",'normalized','Position',[0,0,1,1]);

    % Representamos el perfil completo del corte horizontal central de la
    % autocorrelación en función de la coordenada normalizada x/R_0.
    plot(x/lambda,ordenadas,'LineWidth',2,'Color','r','DisplayName','Numérico');

    % Etiquetamos los ejes y agregamos el número de simulación al título.
    xlabel('Eje x [λ]');
    ylabel('C [U.A.]');
    title(['Simulación ',num2str(num_prueba)]);

    % Aplicamos la configuración general definida para los ejes de las
    % gráficas auxiliares.
    configurar_ejes();

    % Exportamos el perfil completo de la autocorrelación.
    exportgraphics(fig_3_1,filename_3_1,'Resolution',resolucion);

    % Cerramos la figura una vez exportada.
    close(fig_3_1)

    % Creamos una tercera figura no visible para representar únicamente la
    % región central del perfil cuya autocorrelación es mayor o igual a 0.50.
    fig_3_2 = figure('Visible',"off","Units",'normalized',...
                     'Position',[0,0,1,1]);

    % Representamos el intervalo comprendido entre el primer y el último
    % índice para los cuales el perfil central satisface C >= 0.50.
    plot(x(idx_1:idx_2)/lambda,ordenadas(idx_1:idx_2),...
        'LineWidth',2,...
        'Color','r',...
        'DisplayName','Numérico');

    % Etiquetamos los ejes y agregamos el número de simulación al título.
    xlabel('Eje x [λ]');
    ylabel('C [U.A.]');
    title(['Simulación ',num2str(num_prueba)]);

    % Aplicamos la configuración general definida para los ejes.
    configurar_ejes();

    % Exportamos la región central del perfil de autocorrelación.
    exportgraphics(fig_3_2,filename_3_2,'Resolution',resolucion);

    % Cerramos la figura una vez exportada.
    close(fig_3_2)

    % Creamos una cuarta figura no visible para analizar las regiones del
    % perfil de autocorrelación comprendidas por debajo del nivel 0.50.
    fig_3_3 = figure('Visible',"off","Units",'normalized',...
                     'Position',[0,0,1,1]);

    % Representamos nuevamente el perfil horizontal completo de la
    % autocorrelación.
    plot(x/lambda,ordenadas,...
        'LineWidth',2,...
        'Color','r',...
        'DisplayName','Numérico');

    % Etiquetamos los ejes y agregamos el número de simulación al título.
    xlabel('Eje x [λ]');
    ylabel('C [U.A.]');
    title(['Simulación ',num2str(num_prueba)]);

    % Aplicamos la configuración general definida para los ejes.
    configurar_ejes();

    % Limitamos el eje vertical al intervalo comprendido entre el valor
    % mínimo del perfil y 0.50 para destacar las regiones de menor
    % autocorrelación.
    ylim([min(ordenadas) 0.5])

    % Exportamos la representación del perfil restringida al nivel C <= 0.50.
    exportgraphics(fig_3_3,filename_3_3,'Resolution',resolucion);

    % Cerramos la figura una vez exportada.
    close(fig_3_3)

end