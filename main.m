clc;clear;close all;
tic
%% Carga de imagen.
I = imread('sudokus/1.png');
imshow(I);

%% Procesado de la imagen
procesadoSudoku;

%% Reconocimiento de la imagen.
load red_entrenada.mat;

reconocimiento;
matriz

%% Resolucion del Sudoku.
resoluble = comprobar_Sudoku(matriz);
if(resoluble)
    figure();
    SudokuResuelto = solver_pocho(matriz)
    imprimir_numeros;
else
    fprintf('No se puede resolver\n');
end
toc
