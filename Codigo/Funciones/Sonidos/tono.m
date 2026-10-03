% Genera una señal acústica breve con un barrido ascendente de frecuencia
% para indicar el inicio de la ejecución de la simulación.

function tono()

    % Se define la frecuencia de muestreo utilizada para generar la señal
    % de audio.
    fs = 44100;
    
    % Se genera un vector temporal con una duración de 0.18 segundos y un
    % intervalo de muestreo determinado por la frecuencia fs.
    t = 0:1/fs:0.18;
    
    % Se genera un barrido lineal ascendente de frecuencia entre 900 Hz y
    % 1200 Hz a lo largo del intervalo temporal definido.
    f = linspace(900,1200,length(t));
    
    % Se genera la señal sinusoidal de frecuencia variable mediante la
    % integración numérica de la frecuencia instantánea para obtener la fase.
    y = sin(2*pi.*cumtrapz(t,f));
    
    % Se construye una envolvente a partir de una ventana de Hann para
    % suavizar el inicio y el final de la señal.
    env = hann(length(t))'.^0.7;
    
    % Se aplica la envolvente a la señal y se reduce su amplitud para
    % controlar el volumen de reproducción.
    y = 0.35*y.*env;
    
    % Se reproduce la señal generada utilizando la frecuencia de muestreo
    % especificada.
    sound(y,fs)

end