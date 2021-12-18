function [M] = solver_pocho(M)
% Si se desea visualizar el proceso por el que se resuelve el sudoku,
% descomentar las siguientes lineas.

% pause(0.001);
% imagesc(M);colorbar;

indice = find(~M); % Se buscan los valores iguales a 0 en la matriz

s=M; % Se guarda la matriz
% Se comprueba si el sudoku esta completo
acabado = isempty(find(~M));
k=1;
if(acabado==false)
    % Se pasa el indice a las coordenadas de la matriz
    [i,j] = ind2sub([9,9],indice(1));
end
while(acabado==false && k<10)
    % Mientras el sudoku no este acabado o no se haya superado 9
    % Se carga la matriz y se busca la submatriz en la que se encuentra el
    % indiec
    M=s;
    indX = (ceil(i/3)-1)*3+1;
    indY = (ceil(j/3)-1)*3+1;
    submatriz = M(indX:indX+2,indY:indY+2);
    % Si el valor k puede ser introducido
    if sum(M(i,:)==k)==0 & sum(M(:,j)==k)==0 & sum(submatriz(:)==k)==0
        M=s;
        % Se añade ese valor en la posicion deseada y se vuelve a llamar a
        % la funcion
        M(i,j) = k; 
        M = solver_pocho(M);  
        % Se comprueba si ha finalizado la ejecucion
        acabado = isempty(find(~M));
    end  
    k=k+1;
end
% if(acabado==false)
%    M=s; 
% end
% fprintf('Me he quedado sin posibilidades de movimiento en %d %d\n',i,j);

end

