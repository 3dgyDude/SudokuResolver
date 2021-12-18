clc;clear;close all;
digitDatasetPath = fullfile(matlabroot,'toolbox','nnet','nndemos', ...
    'nndatasets','DigitDataset');
imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true,'LabelSource','foldernames'); 
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.75);

labelCount = countEachLabel(imds);

net = mobilenetv2;

