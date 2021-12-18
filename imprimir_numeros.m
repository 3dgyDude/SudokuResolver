%% Colocacacion del sudoku resuelto sobre la imagen original.

% I_recortada = imcrop(I,boundingBox);
% % I_recortada2 = imwarp(I_recortada,tform);
% % figure();imshow(I_recortada2);

% Se redondea la boundingBox, guardada en el script 'procesadoSudoku' 
% para poder usar ahora sus valores en matrices
boundingBox=round(boundingBox); 

% % % propiedades = regionprops(I_recortada2,'Perimeter','BoundingBox');
% % I_recortada3 = imcrop(I_recortada2,boundingbox2);
% % imshow(I_recortada3);
% INumeros = ones(size(I_recortada));

INumeros = ones(m,n,3); % Se inicializa una matriz con el tamaño del sudoku.
for i=1:9
    for j=1:9
        if(matriz(j,i)==0)  
            % Si el valor de la matriz sin resolver es 0, se coloca ese
            % numero en la matriz INumeros
            INumeros = insertText(INumeros,[alto*(i-0.5),largo*(j-0.5)],SudokuResuelto(j,i),'FontSize',round(alto/2),'BoxOpacity',0,'AnchorPoint','Center');
%             imshow(INumeros);
        end
    end 
end
figure();imshow(INumeros);
% Se transforma la imagen del sudoku resuelto, para que tenga la misma
% direccion que en la imagen original.
INumeros2 = imwarp(INumeros,tforminversa,'FillValues',1);
figure();imshow(INumeros2);

% Se crea una copia de la imagen I
Iprueba = I;
% Se reescala la imagen del sudoku completo para que tenga el tamaño
% correcto.
INumeros2 = uint8(imresize(INumeros2,[boundingBox(4)+1,boundingBox(3)+1])*255);
% Se coloca en su sitio de la imagen original.
Iprueba(boundingBox(2):boundingBox(2)+boundingBox(4),boundingBox(1):boundingBox(1)+boundingBox(3),:)=INumeros2;

% Se muestra primero la imagen origonal
figure();imshow(I);
hold on;
% Por encima se muestra la imagen modificada con los numeros colocados.
im = image(Iprueba);
im.AlphaData=0;
% Se modifica el canal alpha de la imagen modificada de forma que 
% que desaparezca el fondo de Iprueba y solo queden los numeros
% (Si hay valores fuera del sudoku que desaparecen no pasa nada por que por
% debajo esta la imagen original, que tiene los mismo valores)
set(im,'AlphaData',Iprueba(:,:,2)<100);
% rectangle('Position',boundingBox,'LineWidth',3,'EdgeColor','y');


% set(im,'AlphaData',Iprueba(:,:,1)==0);
% set(im,'AlphaData',Iprueba(:,:,1)==0);
% alpha(im,0);
% im. = INumeros2==255;
% im.AlphaData =0;




