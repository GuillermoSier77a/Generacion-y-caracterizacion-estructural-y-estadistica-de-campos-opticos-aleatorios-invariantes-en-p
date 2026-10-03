function graficos_lente_3f(resolucion,lambda,filename_13,estilo,I_lente,filename_14,I_3f,num_prueba,x)

% Generamos los gráficos auxiliares

% Creamos una figura no visible para representar la distribución de
% irradiancia obtenida en el plano de Fourier ubicado en z = 2f.
fig_0 = figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);

% Representamos la distribución de irradiancia en el plano de Fourier
% utilizando coordenadas espaciales normalizadas respecto a R_0.
imagesc(x/lambda,x/lambda,I_lente);

% Orientamos el eje vertical de manera que sus valores aumenten de
% abajo hacia arriba.
set(gca,'YDir','normal') 

% Indicamos en el título el número de simulación y la posición del
% plano representado.
title(['Simulación ',num2str(num_prueba),' (z = f)'],'FontWeight','bold');

% Etiquetamos los ejes espaciales normalizados respecto a R_0.
xlabel('Eje x [λ]','FontWeight','bold');
ylabel('Eje y [λ]','FontWeight','bold');

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
% con una resolución de resolucion dpi.
exportgraphics(fig_0,filename_13,'Resolution',resolucion)

% Cerramos la figura una vez exportada.
close(fig_0)

% Creamos una figura no visible para representar la distribución de
% irradiancia obtenida en el plano de Fourier ubicado en z = 2f.
fig_4 = figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);

% Representamos la distribución de irradiancia en el plano de Fourier
% utilizando coordenadas espaciales normalizadas respecto a R_0.
imagesc(x/lambda,x/lambda,I_3f);

% Orientamos el eje vertical de manera que sus valores aumenten de
% abajo hacia arriba.
set(gca,'YDir','normal') 

% Indicamos en el título el número de simulación y la posición del
% plano representado.
title(['Simulación ',num2str(num_prueba),' (z = 3f)'],'FontWeight','bold');

% Etiquetamos los ejes espaciales normalizados respecto a R_0.
xlabel('Eje x [λ]','FontWeight','bold');
ylabel('Eje y [λ]','FontWeight','bold');

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
% con una resolución de resolucion dpi.
exportgraphics(fig_4,filename_14,'Resolution',resolucion)

% Cerramos la figura una vez exportada.
close(fig_4)

end