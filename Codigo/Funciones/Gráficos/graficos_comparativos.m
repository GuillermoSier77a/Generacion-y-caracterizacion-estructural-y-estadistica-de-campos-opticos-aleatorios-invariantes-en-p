function graficos_comparativos(filename_9,filename_10,filename_8,resolucion,filename_7_g,filename_7_s,filename_7_l,num_pruebas,ruta_de_carpeta_de_simulaciones)

    % Se genera un vector que identifica cada una de las simulaciones
    % realizadas.
    vector_pruebas = 1:num_pruebas;

    % Se inicializan los vectores destinados a almacenar los parámetros y
    % resultados obtenidos en cada simulación.
    vector_radios = zeros(1,num_pruebas);
    vector_grosor = zeros(1,num_pruebas);
    vector_size_de_grano_x = zeros(1,num_pruebas);
    vector_FWC_50 = zeros(1,num_pruebas);
    vector_FWC_75 = zeros(1,num_pruebas);
    vector_FWC_25 = zeros(1,num_pruebas);
    vector_p_prom = zeros(1,num_pruebas);
    vector_r_prom = zeros(1,num_pruebas);
    vector_tiempo = zeros(1,num_pruebas);
        
    % Se recorren las carpetas correspondientes a cada simulación para
    % recuperar los parámetros y resultados almacenados en sus archivos CSV.
    for i = 1:num_pruebas

        % Se construye la ruta de la carpeta correspondiente a la simulación
        % actual.
        carpeta = fullfile(ruta_de_carpeta_de_simulaciones,sprintf('Simulación %d',i));

        % Se construye la ruta del archivo que contiene los parámetros y
        % resultados obtenidos durante la propagación.
        archivo = fullfile(carpeta,'Parámetros y resultados de propagación.csv');
    
        % Se leen los datos almacenados en el archivo CSV de la simulación.
        datos = readmatrix(archivo);
    
        % Se extraen los parámetros geométricos del campo y del difusor,
        % así como los resultados del análisis de la propagación.
        vector_radios(1,i) = datos(1,12);
        vector_grosor(1,i) = datos(1,13);
        vector_size_de_grano_x(1,i) = datos(1,10);
        vector_FWC_50(1,i) = datos(1,17);
        vector_FWC_75(1,i) = datos(1,18);
        vector_FWC_25(1,i) = datos(1,19);
        vector_p_prom(1,i) = datos(1,20);
        vector_r_prom(1,i) = datos(1,21);
        vector_tiempo(1,i) = datos(1,22);
    
    end

    % Se crea una figura no visible para representar el ancho completo de
    % la autocorrelación al 50 % de su valor máximo en función de R_0.
    fig_1 = figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);

    % Se representa FWC_{0.50}, normalizado respecto a R_0, en función del
    % radio central utilizado en cada simulación.
    plot(vector_radios,vector_FWC_50,'LineWidth',3,'Color','r','Marker','o','MarkerFaceColor','k','MarkerSize',6,'MarkerEdgeColor','none');
    hold on

    % Se etiquetan los ejes con las magnitudes correspondientes.
    xlabel('R_0 [λ]','FontWeight','bold');
    ylabel('FWC_{0.50} [λ]','FontWeight','bold');

    % La siguiente instrucción permite agregar un título a la gráfica.
    % title('FW_{C_{0.5}} en función del número de simulación');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica utilizando la resolución especificada.
    exportgraphics(fig_1,filename_7_g,'Resolution',resolucion)

    % Se cierra la figura una vez exportada.
    close(fig_1)

    % Se crea una figura no visible para representar el ancho completo de
    % la autocorrelación al 75 % de su valor máximo en función de R_0.
    fig_2 = figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);

    % Se representa FWC_{0.75}, normalizado respecto a R_0, en función del
    % radio central utilizado en cada simulación.
    plot(vector_radios,vector_FWC_75,'LineWidth',3,'Color','r','Marker','o','MarkerFaceColor','k','MarkerSize',6,'MarkerEdgeColor','none');
    hold on

    % Se etiquetan los ejes con las magnitudes correspondientes.
    xlabel('R_0 [λ]','FontWeight','bold');
    ylabel('FWC_{0.75} [λ]','FontWeight','bold');

    % La siguiente instrucción permite agregar un título a la gráfica.
    % title('FWHM_s en función del número de simulación');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica utilizando la resolución especificada.
    exportgraphics(fig_2,filename_7_s,'Resolution',resolucion)

    % Se cierra la figura una vez exportada.
    close(fig_2)

    % Se crea una figura no visible para representar el ancho completo de
    % la autocorrelación al 25 % de su valor máximo en función de R_0.
    fig_3 = figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);

    % Se representa FWC_{0.25}, normalizado respecto a R_0, en función del
    % radio central utilizado en cada simulación.
    plot(vector_radios,vector_FWC_25,'LineWidth',3,'Color','r','Marker','o','MarkerFaceColor','k','MarkerSize',6,'MarkerEdgeColor','none');
    hold on

    % Se etiquetan los ejes con las magnitudes correspondientes.
    xlabel('R_0 [λ]','FontWeight','bold');
    ylabel('FWC_{0.25} [λ]','FontWeight','bold');

    % La siguiente instrucción permite agregar un título a la gráfica.
    % title('FWHM_l en función del número de simulación');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica utilizando la resolución especificada.
    exportgraphics(fig_3,filename_7_l,'Resolution',resolucion)

    % Se cierra la figura una vez exportada.
    close(fig_3)

    % Se crea una figura no visible para analizar el comportamiento de la
    % potencia óptica promedio en función del radio central R_0.
    fig_5 = figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);

    % Se representa la potencia óptica promedio obtenida durante la
    % propagación para cada valor del radio central.
    plot(vector_radios,vector_p_prom,'LineWidth',3,'Color','r','Marker','o','MarkerFaceColor','k','MarkerSize',6,'MarkerEdgeColor','none');
    hold on

    % Se etiquetan los ejes con las magnitudes correspondientes.
    xlabel('R_0 [λ]','FontWeight','bold');
    ylabel('μ_P [U.A.]','FontWeight','bold');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica utilizando la resolución especificada.
    exportgraphics(fig_5,filename_9,'Resolution',resolucion)

    % Se cierra la figura una vez exportada.
    close(fig_5)

    % Se crea una figura no visible para analizar el comportamiento del
    % coeficiente de correlación promedio en función del radio central R_0.
    fig_6 = figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);

    % Se representa el coeficiente de correlación promedio obtenido durante
    % la propagación para cada valor del radio central.
    plot(vector_radios,vector_r_prom,'LineWidth',3,'Color','r','Marker','o','MarkerFaceColor','k','MarkerSize',6,'MarkerEdgeColor','none');
    hold on
    
    % Se etiquetan los ejes con las magnitudes correspondientes.
    xlabel('R_0 [λ]','FontWeight','bold');
    ylabel('μ_R [U.A.]','FontWeight','bold');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica utilizando la resolución especificada.
    exportgraphics(fig_6,filename_10,'Resolution',resolucion)

    % Se cierra la figura una vez exportada.
    close(fig_6)
   
    % Se crea una figura no visible para comparar el tiempo de cómputo
    % requerido por cada una de las simulaciones.
    fig_4 = figure('Visible',"off","Units", 'normalized', 'Position', [0, 0, 1, 1]);

    % Se representa el tiempo de ejecución en función del número de
    % simulación.
    plot(vector_pruebas,vector_tiempo,'LineWidth',3,'Color','r','Marker','o','MarkerFaceColor','k','MarkerSize',6,'MarkerEdgeColor','none');
    hold on

    % Se etiquetan los ejes con el número de simulación y el tiempo de
    % ejecución expresado en minutos.
    xlabel('Número de simulación','FontWeight','bold');
    ylabel('t [min]','FontWeight','bold');

    % La siguiente instrucción permite agregar un título a la gráfica.
    % title('Tiempo de ejecución de las simulaciones');

    % Se aplica la configuración general definida para los ejes.
    configurar_ejes()

    % Se exporta la gráfica utilizando la resolución especificada.
    exportgraphics(fig_4,filename_8,'Resolution',resolucion)

    % Se cierra la figura una vez exportada.
    close(fig_4)

end