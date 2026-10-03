% Genera una señal acústica para indicar que la ejecución de la simulación
% ha fallado.

function sonido_de_falla()

    % Se define la frecuencia de muestreo utilizada para generar la señal
    % de audio.
    fs = 44100;
    
    % Se genera un vector temporal con una duración de 0.5 segundos y un
    % intervalo de muestreo determinado por la frecuencia fs.
    t = 0:1/fs:0.5;
    
    % Se definen las frecuencias inicial y final del barrido de frecuencia.
    f0 = 800;
    f1 = 300;
    
    % Se genera una señal chirp con un barrido lineal descendente desde
    % la frecuencia f0 hasta la frecuencia f1 durante el intervalo definido.
    y = chirp(t,f0,t(end),f1,'linear');
    
    % Se aplica una ventana de Hann para suavizar el inicio y el final de
    % la señal y se reduce su amplitud para controlar el volumen.
    y = 0.45*y.*hann(length(y))';
    
    % Se reproduce la señal generada utilizando la frecuencia de muestreo
    % especificada.
    sound(y,fs)

end