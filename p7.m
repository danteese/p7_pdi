% Integrantes: 
% Dante Bazaldua 
% Leonardo Lopez

%% Parte 2
clc; clear;
img = imread('flexible.tif');

gray = mat2gray(double(img));
% Fourier transform
img_fft = fft2(gray);
img_fftsh = fftshift(img_fft);

[ix, iy] = size(img_fftsh);
vx = -1:1/230:1;
vy = -1:1/246:1;