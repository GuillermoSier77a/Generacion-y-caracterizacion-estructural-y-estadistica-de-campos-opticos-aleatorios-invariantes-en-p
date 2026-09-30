% Genera una señal acústica para indicar que la ejecución de la simulación
% ha finalizado correctamente.

function terminado()

    % Se define la frecuencia de muestreo utilizada para generar las señales
    % de audio.
    fs = 44100;
    
    % Se definen las frecuencias correspondientes a las notas Do5, Mi5, Sol5
    % y Do6 que conforman la primera secuencia sonora.
    notas = [523.25 659.25 783.99 1046.50]; % Do5 Mi5 Sol5 Do6
    
    % Se establece la duración, en segundos, de cada una de las notas de la
    % primera secuencia.
    duraciones = [0.15 0.15 0.15 0.4];
    
    % Se recorren las notas que conforman la primera secuencia sonora.
    for k = 1:length(notas)
    
        % Se genera el vector temporal correspondiente a la duración de la nota
        % actual y a la frecuencia de muestreo especificada.
        t = 0:1/fs:duraciones(k);
    
        % Se genera una señal sinusoidal con la frecuencia correspondiente a la
        % nota actual.
        y = sin(2*pi*notas(k)*t);
    
        % Se aplica una ventana de Hann para suavizar el inicio y el final de
        % la señal y evitar discontinuidades que produzcan clics audibles.
        ventana = hann(length(y))';
        y = y.*ventana;
    
        % Se reproduce la nota utilizando la frecuencia de muestreo definida.
        sound(y,fs)
    
        % Se introduce una pausa que permite finalizar la reproducción de la
        % nota antes de generar la siguiente.
        pause(duraciones(k)+0.05)
    
    end
    
    % Se define nuevamente la frecuencia de muestreo utilizada para generar la
    % segunda secuencia sonora.
    fs = 44100;
    
    % Se definen las frecuencias correspondientes a las notas que conforman la
    % segunda secuencia sonora.
    notas = [523.25 659.25 783.99 1046.50 783.99 1046.50];
    
    % Se establece una duración común, en segundos, para todas las notas de la
    % segunda secuencia.
    dur = 0.12;
    
    % Se recorren directamente las frecuencias de las notas que conforman la
    % segunda secuencia sonora.
    for f = notas
    
        % Se genera el vector temporal correspondiente a la duración de cada
        % nota y a la frecuencia de muestreo especificada.
        t = 0:1/fs:dur;
    
        % Se genera una señal sinusoidal con la frecuencia correspondiente a la
        % nota actual.
        y = sin(2*pi*f*t);
    
        % Se genera una envolvente mediante una ventana de Hann y se aplica a
        % la señal para suavizar su inicio y final.
        env = hann(length(y))';
        y = y.*env;
    
        % Se reproduce la nota utilizando la frecuencia de muestreo definida.
        sound(y,fs)
    
        % Se introduce una pausa correspondiente a la duración de la nota antes
        % de continuar con la siguiente.
        pause(dur)
    
    end

end