function configurar_ejes()

    % Orientamos el eje vertical de manera que sus valores aumenten de
    % abajo hacia arriba.
    set(gca,'YDir','normal')
    
    % Configuramos el tamaño y el grosor de la fuente de los ejes.
    set(gca,'FontSize',15,'FontWeight','bold')
    
    % Establecemos la misma escala espacial en ambos ejes.
    axis equal
    
    % Ajustamos los límites de los ejes al intervalo de los datos mostrados.
    axis tight
    
    % Configuramos el área de los ejes para que tenga una forma cuadrada.
    axis square
    
    % Activamos la cuadrícula principal de los ejes.
    grid on
    
    % Activamos la cuadrícula secundaria para mostrar divisiones adicionales.
    grid minor

end