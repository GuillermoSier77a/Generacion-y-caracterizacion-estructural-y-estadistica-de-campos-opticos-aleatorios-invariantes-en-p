function [promedio_de_correlacion] = graficos_correlacion(distancia_focal,filename_2,num_prueba,vector_z,correlacion,posicion_de_la_lente)

    % Colores
    
    % Se define el color verde utilizado para identificar la posición de la
    % lente dentro de la gráfica.
    verde   = [0.00, 0.60, 0.20];
    
    % Se crea una figura no visible destinada a representar la evolución del
    % coeficiente de correlación a lo largo de la propagación.
    fig_2 = figure('Visible',"off",'Units','normalized','Position',[0, 0, 1, 1]);
    
    % ================================================================
    % Curva de correlación
    % ================================================================
    
    % Se representa el coeficiente de correlación en función de la distancia
    % de propagación normalizada respecto a la distancia focal. Se consideran
    % los valores comprendidos desde la posición de la lente hasta el final
    % del intervalo de propagación.
    plot(vector_z(posicion_de_la_lente:end)/distancia_focal,correlacion,'Color','r','Marker','o','MarkerSize',6,'MarkerFaceColor','k','MarkerEdgeColor','none','LineWidth',3);
    
    % Se conserva la gráfica actual para incorporar las líneas verticales que
    % indican las posiciones características del sistema óptico.
    hold on
    
    % ================================================================
    % Plano de Fourier
    % ================================================================
    
    % Se incorpora una línea vertical en z = 2f para indicar la posición del
    % plano de Fourier dentro del intervalo de propagación.
    h1 = xline(2,'--',...
        'Color','b',...
        'LineWidth',3,...
        'DisplayName','Plano de Fourier = 2f');
    
    % ================================================================
    % Lente
    % ================================================================
    
    % Se incorpora una línea vertical en z = f para indicar la posición de la
    % lente dentro del sistema óptico.
    h0 = xline(1,'--','Color',verde,'LineWidth',3,'DisplayName','Lente = f');
    
    % ================================================================
    % Ejes
    % ================================================================
    
    % Se indica en el título el número correspondiente a la simulación.
    title(['Simulación ',num2str(num_prueba)],'FontWeight','bold');
    
    % Se etiqueta el eje horizontal mediante la distancia de propagación
    % normalizada respecto a la distancia focal.
    xlabel('Eje z [f]','FontWeight','bold');
    
    % Se etiqueta el eje vertical con la magnitud representada.
    ylabel('R [U.A.]','FontWeight','bold');
    
    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()
    
    % ================================================================
    % Leyenda
    % ================================================================
    
    % Se genera una leyenda para identificar las posiciones de la lente y del
    % plano de Fourier.
    legend([h0 h1],'Location','northeast','FontWeight','bold','Box','on');
    
    % ================================================================
    % Exportación
    % ================================================================
    
    % Se exporta la gráfica del coeficiente de correlación utilizando una
    % resolución de 300 dpi.
    exportgraphics(fig_2,filename_2,'Resolution',300);
    
    % Se cierra la figura una vez exportada.
    close(fig_2)
    
    % Se calcula el valor promedio del coeficiente de correlación a lo largo
    % del intervalo de propagación considerado.
    promedio_de_correlacion = mean(correlacion);

end