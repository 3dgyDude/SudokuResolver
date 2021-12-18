function [Resoluble] = comprobar_Sudoku(sudoku)
Resoluble = true;
if(size(sudoku,1)~=9 || size(sudoku,2)~=9)
    Resoluble = false;
    
else
    for i=1:9
        row = sudoku(i,:);row = row(row~=0);
        col = sudoku(:,i);col = col(col~=0);
        if( ~isempty(find(histcounts(row) > 1)) && ~isempty(find(histcounts(row) > 1)))
            fprintf('El sudoku esta mal %d\n',i);
            Resoluble = false;
        end
    end
    for i=0:2
        submatriz1 = sudoku(3*i+1:3*i+3,1:3);submatriz1 = submatriz1(submatriz1~=0);
        submatriz2 = sudoku(3*i+1:3*i+3,4:6);submatriz2 = submatriz2(submatriz2~=0);
        submatriz3 = sudoku(3*i+1:3*i+3,7:9);submatriz3 = submatriz3(submatriz3~=0);

        if( ~isempty(find(histcounts(submatriz1) > 1)) || ~isempty(find(histcounts(submatriz2) > 1)) || ~isempty(find(histcounts(submatriz3) > 1)))
            fprintf('El sudoku esta mal (Submatriz)%d\n',i);
            Resoluble = false;
        end
    end
end
end

