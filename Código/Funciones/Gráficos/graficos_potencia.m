function [promedio_de_potencia] = graficos_potencia(resolucion,distancia_focal,filename_1,num_prueba,vector_z,Potencia)

    % Colores
    
    % Se define el color verde utilizado para identificar la posición de la
    % lente dentro de la gráfica.
    verde   = [0.00, 0.60, 0.20];
    
    % Se crea una figura no visible destinada a representar la evolución
    % de la potencia óptica a lo largo de la propagación.
    fig_1 = figure('Visible',"off",'Units','normalized','Position',[0, 0, 1, 1]);
    
    % ================================================================
    % Curva de potencia
    % ================================================================
    
    % Se normaliza la potencia óptica respecto a su valor en el plano
    % inicial de propagación.
    potencia_norm = Potencia/Potencia(1);
    
    % Se representa la potencia óptica normalizada en función de la
    % distancia de propagación, expresada en unidades de la distancia focal.
    plot(vector_z/distancia_focal,potencia_norm,'Color','r','Marker','o','MarkerSize',6,'MarkerFaceColor','k','MarkerEdgeColor','none','LineWidth',3);
    
    % Se conserva la gráfica actual para incorporar las líneas verticales
    % correspondientes a las posiciones características del sistema óptico.
    hold on
    
    % ================================================================
    % Plano de Fourier
    % ================================================================
    
    % Se incorpora una línea vertical en z = 2f para indicar la posición
    % del plano de Fourier dentro del intervalo de propagación.
    h1 = xline(2,'--',...
        'Color','b',...
        'LineWidth',3,...
        'DisplayName','Plano de Fourier = 2f');
    
    % ================================================================
    % Lente
    % ================================================================
    
    % Se incorpora una línea vertical en z = f para indicar la posición de
    % la lente dentro del sistema óptico.
    h0 = xline(1,'--','Color',verde,'LineWidth',3,'DisplayName','Lente = f');
    
    % ================================================================
    % Ejes
    % ================================================================
    
    % Se indica en el título el número correspondiente a la simulación.
    title(['Simulación ',num2str(num_prueba)],'FontWeight','bold');
    
    % Se etiqueta el eje horizontal mediante la distancia de propagación
    % normalizada respecto a la distancia focal.
    xlabel('Eje z [f]','FontWeight','bold');
    
    % Se etiqueta el eje vertical con la potencia óptica normalizada.
    ylabel('P [U.A.]','FontWeight','bold');
    
    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()
    
    % ================================================================
    % Leyenda
    % ================================================================
    
    % Se genera una leyenda para identificar las posiciones de la lente y
    % del plano de Fourier.
    legend([h0 h1],'Location','northeast','FontWeight','bold','Box','on');
    
    % ================================================================
    % Exportación
    % ================================================================
    
    % Se exporta la gráfica de la potencia óptica normalizada utilizando
    % una resolución igual al valor de la variable resolucion.
    exportgraphics(fig_1,filename_1,'Resolution',resolucion);
    
    % Se cierra la figura una vez exportada.
    close(fig_1)
    
    % Se calcula el valor promedio de la potencia óptica normalizada a lo
    % largo de todo el intervalo de propagación considerado.
    promedio_de_potencia = mean(potencia_norm);

end