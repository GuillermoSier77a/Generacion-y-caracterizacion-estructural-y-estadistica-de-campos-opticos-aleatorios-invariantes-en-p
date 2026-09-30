function graficos_campos(radio_exterior,R_0,filename_12,estilo,I1,filename_11,I_ref,num_prueba,x)
    
    % Generamos los gráficos auxiliares
    
    % Creamos una figura no visible para representar la distribución de
    % irradiancia obtenida en el plano de Fourier ubicado en z = 2f.
    fig_0 = figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);
    
    % Representamos la distribución de irradiancia en el plano de Fourier
    % utilizando coordenadas espaciales normalizadas respecto a R_0.
    imagesc(x/R_0,x/R_0,I_ref);
    
    % Orientamos el eje vertical de manera que sus valores aumenten de
    % abajo hacia arriba.
    set(gca,'YDir','normal') 
    
    % Indicamos en el título el número de simulación y la posición del
    % plano representado.
    title(['Simulación ',num2str(num_prueba),' (z = 2f)'],'FontWeight','bold');
    
    % Etiquetamos los ejes espaciales normalizados respecto a R_0.
    xlabel('Eje x [R_0]','FontWeight','bold');
    ylabel('Eje y [R_0]','FontWeight','bold');
    
    % Configuramos el tamaño y el grosor de la fuente de los ejes.
    set(gca,'FontSize',15,'FontWeight','bold')
    
    % Establecemos la misma escala espacial en ambos ejes y ajustamos sus
    % límites al intervalo de los datos mostrados.
    axis equal
    axis tight
    
    % Agregamos una barra de color y aplicamos el mapa de colores
    % seleccionado para representar los valores de irradiancia.
    cb = colorbar;
    colormap(gca, estilo)
    
    % Etiquetamos la barra de color indicando la magnitud representada.
    ylabel(cb,'Irradiancia [U.A.]','FontWeight','bold')
    
    % Exportamos la distribución de irradiancia en el plano de Fourier
    % con una resolución de 300 dpi.
    exportgraphics(fig_0,filename_12,'Resolution',300)
    
    % Cerramos la figura una vez exportada.
    close(fig_0)
    
    % Localizamos los índices del vector x más cercanos a los extremos
    % espaciales -radio_exterior y +radio_exterior. Estos índices delimitan
    % la región que contiene el anillo del campo inicial.
    [~,anillo_izquierdo] = min(abs(x + radio_exterior));
    [~,anillo_derecho]   = min(abs(x - radio_exterior));
    
    % Creamos una segunda figura no visible para representar la distribución
    % de irradiancia del campo inicial en z = 0.
    fig_4 = figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);
    
    % Representamos únicamente la región espacial comprendida entre
    % -radio_exterior y +radio_exterior. Las coordenadas se convierten a
    % milímetros multiplicándolas por 10.
    imagesc(x(anillo_izquierdo:anillo_derecho)*10,x(anillo_izquierdo:anillo_derecho)*10,I1(anillo_izquierdo:anillo_derecho,anillo_izquierdo:anillo_derecho));
    
    % Orientamos el eje vertical de manera que sus valores aumenten de
    % abajo hacia arriba.
    set(gca,'YDir','normal')
    
    % Indicamos en el título el número de simulación y que la distribución
    % corresponde al campo inicial ubicado en z = 0.
    title(['Simulación ',num2str(num_prueba),' (z = 0)'],'FontWeight','bold');
    
    % Etiquetamos los ejes espaciales expresados en milímetros.
    xlabel('Eje x [mm]','FontWeight','bold');
    ylabel('Eje y [mm]','FontWeight','bold');
    
    % Configuramos el tamaño y el grosor de la fuente de los ejes.
    set(gca,'FontSize',15,'FontWeight','bold')
    
    % Establecemos la misma escala espacial en ambos ejes y ajustamos sus
    % límites a la región mostrada.
    axis equal
    axis tight
    
    % Agregamos una barra de color y aplicamos el mapa de colores
    % seleccionado para representar los valores de irradiancia.
    cb = colorbar;
    colormap(gca, estilo)
    
    % Etiquetamos la barra de color indicando la magnitud representada.
    ylabel(cb,'Irradiancia [U.A.]','FontWeight','bold')
    
    % Exportamos la distribución de irradiancia del campo inicial con una
    % resolución de 300 dpi.
    exportgraphics(fig_4,filename_11,'Resolution',300)
    
    % Cerramos la figura una vez exportada.
    close(fig_4)

end