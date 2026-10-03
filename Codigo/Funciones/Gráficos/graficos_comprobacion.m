function graficos_comprobacion(resolucion,z_R,filename_0,num_prueba,vector_z,comprobacion)

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
plot(vector_z/z_R,comprobacion,'Color','r','Marker','o','MarkerSize',6,'MarkerFaceColor','k','MarkerEdgeColor','none','LineWidth',3);

% ================================================================
% Ejes
% ================================================================

% Se indica en el título el número correspondiente a la simulación.
title(['Simulación ',num2str(num_prueba)],'FontWeight','bold');

% Se etiqueta el eje horizontal mediante la distancia de propagación
% normalizada respecto a la distancia focal.
xlabel('Eje z [z_R]','FontWeight','bold');

% Se etiqueta el eje vertical con la magnitud representada.
ylabel('R [U.A.]','FontWeight','bold');

% Se aplica la configuración general definida para los ejes.
configurar_ejes()

% ================================================================
% Exportación
% ================================================================

% Se exporta la gráfica del coeficiente de correlación utilizando una
% resolución igual al valor de la variable resolucion.
exportgraphics(fig_2,filename_0,'Resolution',resolucion);

% Se cierra la figura una vez exportada.
close(fig_2)

end