function frame = hacer_dimensiones_pares(frame)

    % Obtenemos la altura y el ancho, en píxeles, del frame de entrada.
    [alto, ancho, ~] = size(frame);
    
    % Verificamos si la altura contiene un número impar de píxeles. En ese
    % caso, reducimos su dimensión en un píxel para obtener una altura par.
    if mod(alto,2) ~= 0
        alto = alto - 1;
    end
    
    % Verificamos si el ancho contiene un número impar de píxeles. En ese
    % caso, reducimos su dimensión en un píxel para obtener un ancho par.
    if mod(ancho,2) ~= 0
        ancho = ancho - 1;
    end
    
    % Redimensionamos el frame utilizando las dimensiones pares calculadas,
    % garantizando que tanto su altura como su ancho sean números pares.
    frame = imresize(frame,[alto ancho]);

end