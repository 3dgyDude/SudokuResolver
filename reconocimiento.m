%% Reconocimiento del Sudoku.

[m,n] = size(sudoku); % Tomamos las dimensiones del sudoku
alto = round(n/9);  % La dividimos entre 9 para obtener el alto del sudoku
largo = round(m/9); % Igual para la altura

% Buscamos todas las regiones dentro del sudoku
propiedades = regionprops(~sudoku,'Centroid','BoundingBox','Area','Perimeter');

% Mostramos el sudoku fuera del Live Script.
f = figure();
set(f,'Visible','on');
imshow(sudoku);hold on;

matriz = zeros(9,9); % Inicializamos la matriz

% Recorremos todas las regiones, exceptuando la primera que es la propia
% del sudoku completo.
for i=2:length(propiedades)
    % Comprobamos si la region es lo suficientemente grande y la comparamos
    % con el largo y el alto de cada casilla del sudoku. De esta forma no
    % se tendran en cuenta areas que sean mayores a una casilla.
    if(propiedades(i).Area > 30 && propiedades(i).BoundingBox(3)<=largo && propiedades(i).BoundingBox(4)<=alto )
    rectangle('Position',propiedades(i).BoundingBox,'LineWidth',3,'EdgeColor','y');
    propiedades(i).BoundingBox(3)=largo/3;
%     imagen = imcrop(sudoku,propiedades(i).BoundingBox);
%     imagen = imcrop(sudoku,[propiedades(i).Centroid-[largo_corte,alto_corte]/2,[largo_corte,alto_corte]]);
    % Recortamos la region y le añadimos ceros a los lados, para dar
    % margen.
    imagen = imcrop(sudoku,propiedades(i).BoundingBox);
    imagen = ~padarray(~imagen,[20,20],'both');
    imagen = imresize(imagen, [128 128]); % Reescalamos la imagen a la de la entrada del clasificador.

    imshow(imagen);pause(0.1);  % Mostramos la imagen que sera reconocida.
    
%     classify(net,uint8(imagen*255)); % Clasificamos
    
    % En funcion de la posicion del centroide se identifica la casilla del
    % sudoku donde se encontraba el numero.
    indiceI = ceil(propiedades(i).Centroid(2)/largo);
    indiceJ = ceil(propiedades(i).Centroid(1)/alto);
    % En caso de que haya un error se evita acceder a posiciones invalidas
    % de la matriz
    if(indiceI < 1) indiceI = 1; end 
    if(indiceJ < 1) indiceJ = 1; end
    if(indiceI > 9) indiceI = 9; end
    if(indiceJ > 9) indiceJ = 9; end
    
    % Clasificamos y guardamos en la matriz.
    matriz(indiceI,indiceJ) = double(classify(net,uint8(imagen*255)));

    end
end

% Numeros = zeros(largo, alto, 81);
% for i=0:8
%     for j=0:8
% %         Numeros(:,:,i+j+1) = imcrop(sudoku,[largo*i,alto*j,largo, alto]);
%         figure();
% %         aux = 
%         imshow(imcrop(sudoku,[largo*i+3,alto*j+3,largo, alto]));
%            
%     end
% end
