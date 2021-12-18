%% Procesado de la imagen.

Igray = rgb2gray(I); % Pasamos la imagen original a escala de grises
imshow(Igray);

Igray = histeq(Igray);

%%
% La imagen en escala de grises se binariza usando un threshold de 0.7
level = adaptthresh(Igray,0.78);
I2 = imbinarize(Igray,level);
% Se eliminan posibles puntos de ruido.
I2 = bwareaopen(~I2,1500);
I2=~I2; %Generamos la imagen complementaria.
figure();
imshow(I2)

%% Enderezado del sudoku
% Buscamos las diferentes regiones de la imagen
propiedades = regionprops(~I2,'Perimeter','BoundingBox','ConvexImage','FilledArea');
% Se busca la region de mayor area cuya forma se asemeje a la de un
% cuadrado, pudiendo diferir el tamaño de sus lados en hasta un 25
% porciento
k=1;
mayorPerimetro = propiedades(1).FilledArea;
for i=2:length(propiedades)
    if(propiedades(i).FilledArea > mayorPerimetro && abs(propiedades(i).BoundingBox(3)-propiedades(i).BoundingBox(4))<0.25*max(propiedades(i).BoundingBox(3),propiedades(i).BoundingBox(4)))
      k=i;  
      mayorPerimetro=propiedades(i).FilledArea;
    end
    rectangle('Position',propiedades(i).BoundingBox,'LineWidth',3,'EdgeColor','y');
end

hold on
rectangle('Position',propiedades(k).BoundingBox,'LineWidth',3,'EdgeColor','r');
I2=imcrop(I2,propiedades(k).BoundingBox); % Recortamos la region que se ha obtenido anteriormente.

boundingBox = propiedades(k).BoundingBox; % Guardamos el tamaño de la boundingBox para ser usada mas adelante

% propiedades = regionprops(~I2,'all');
% for i=1:length(propiedades)
%     rectangle('Position',propiedades(i).BoundingBox,'LineWidth',3,'EdgeColor','y');
% end
% I2=imcrop(I2,propiedades(1).BoundingBox);
% % imshow(I2);

% Usamos la ConvexImage para poder encontrar las esquinas del sudoku.
IConvex = propiedades(k).ConvexImage;
% Buscamos las esquinas del sudoku
[y,x] = find(IConvex);
[~,loc] = min(y+x);
C = [x(loc),y(loc)];
[~,loc] = min(y-x);
C(2,:) = [x(loc),y(loc)];
[~,loc] = max(y+x);
C(3,:) = [x(loc),y(loc)];
[~,loc] = max(y-x);
C(4,:) = [x(loc),y(loc)];

figure();
imshow(I2); hold on
plot(C([1:4 1],1),C([1:4 1],2),'r','linewidth',3); % Mostramos el cuadrilatero que se ha generado.

% I3=propiedades(k).Image;

fixedPoints = [1 1;size(I2,2), 1;size(I2,2) size(I2,1); 1  size(I2,1)];
% Creamos una matriz de transformacion que nos enderece la imagen.
tform = fitgeotrans(C,fixedPoints,'projective');
sudoku=imwarp(~I2,tform); % Transformamos la imagen.

% Tambien guardamos la matriz de transformacion inversa.
tforminversa = fitgeotrans(fixedPoints,C,'projective');
% prueba = imwarp(~sudoku, tforminversa);
% figure();imshow(prueba);

% Mostramos el nuevo sudoku enderezado.
figure();
propiedades = regionprops(sudoku,'Perimeter','BoundingBox','FilledArea');
% boundingbox2 = propiedades(1).BoundingBox;
k=1;
mayorPerimetro = propiedades(1).FilledArea;
for i=2:length(propiedades)
    if(propiedades(i).FilledArea > mayorPerimetro && abs(propiedades(i).BoundingBox(3)-propiedades(i).BoundingBox(4))<0.25*max(propiedades(i).BoundingBox(3),propiedades(i).BoundingBox(4)))
      k=i;  
      mayorPerimetro=propiedades(i).FilledArea;
    end
    rectangle('Position',propiedades(i).BoundingBox,'LineWidth',3,'EdgeColor','y');
end
sudoku = imcrop(~sudoku,propiedades(k).BoundingBox);
imshow(sudoku);


