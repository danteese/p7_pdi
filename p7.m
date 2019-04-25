%% Práctica 7: Eliminación de ruido periodico
% Elabora: Dante Bazaldua y Leonardo Lopez

%% Parte 2
figure
set(gcf, 'Name', 'Filtros rechaza-bandas', 'NumberTitle', 'Off');

%Lectura y transformada de la imagen
img=imread('enluna.tif');
img=mat2gray(double(img));
imgfft=fft2(img);
fftimg=fftshift(imgfft);

%Se crea el filtro rechaza-bandas
%Creamos un vector para el filtro y sacamos su matriz
vector=-1:1/236.5:1; 
[xv,yv]=meshgrid(vector); 
H=CrearFiltro(0.5, 0.79, xv, yv);
% se rellena el filtro con padarray
filtro=padarray(H,[0 78]);

%Multiplicamos el espectro con el filtro y regresamos a la imagen
espectro=fftimg.*filtro; 
img2=fftshift(espectro);
img2=ifft2(img2);
subplot(2,2,1),imshow(img, []),title('Imagen original');
subplot(2,2,2),imshow((abs(fftimg.^0.15)+1),[]),title('Espectro');
subplot(2,2,3),imshow((abs(espectro.^0.15)+1),[]),title('Espectro con filtro');
subplot(2,2,4),imshow(abs(img2),[]),title('Imagen con Filtro');

disp('Parte 2');
pause;

%% Parte 3
figure
set(gcf, 'Name', '4 Bandas de rechazo', 'NumberTitle', 'Off');

%Lectura y transformada de la imagen 
imgf=imread('fox.tif');
imgf=mat2gray(double(imgf));
fftimgf=fft2(imgf);
fftimgf=fftshift(fftimgf);

%Creamos los vectores para crear los filtros
vectorX=-1:1/210:1;
vectorY=-1:1/319.5:1;
[xv,yv]=meshgrid(vectorY,vectorX);

%Se crean los filtros necesarios para limpiar la imagen

%se crea del primer filtro
H1=CrearFiltro(0.2, 1.3, xv, yv);
filtro1 = H1;
%se crea una delta en el centro
filtro1(421,640)= 0;

%Creacion del filtro 2
H2=CrearFiltro(0.18, 0.35, xv, yv);
filtro2 = H2;
filtro2(421,640)= 0;

%Creacion del filtro 3
H3=CrearFiltro(0.2, 0.75, xv, yv);
filtro3 = H3;
filtro3(421,640)= 0;

% Se multiplican los filtros para tener uno total
filtroTotal=filtro1.*filtro2.*filtro3;

%Se multiplucan las frecuencias
filtroTotal=fftimgf.*filtroTotal; 
imgf2 = ifftshift(filtroTotal);
imgf2=ifft2(imgf2);

%Ploteamos los resultados
subplot(2,2,1),imshow(imgf),title('Imagen Original');
subplot(2,2,2),imshow((abs(fftimgf.^0.15)+1),[]),title('Espectro de imagen');
subplot(2,2,3),imshow((abs(filtroTotal.^0.15)+1),[]),title('Espectro con filtro');
subplot(2,2,4),imshow(abs(imgf2),[]),title('Imagen filtrada');

disp('Parte 3');
pause;
%% Parte 4
% Other way to do it: http://www.cs.uregina.ca/Links/class-info/425/Lab5/index.html

% Flexible
clc; clear;
img = imread('flexible.tif');
img_gray = mat2gray(double(img));
img_fft = fft2(img_gray);
img_fftsh = fftshift(img_fft);

[ix, iy] = size(img_fftsh);

% Filter
vx = -1:1/(ceil(ix/2)-1):1;
vy = -1:1/(ceil(iy/2)-1):1;

[mx, my] = meshgrid(vy, vx);

% Overall values
n = 32; u = mx; v = my;

% Las siguientes coordenadas fueron obtenidas del espectro
H1 = notchFilter(0.2, 0.49, 0.37, u, v, n);
H2 = notchFilter(0.2, 0.359, 0.509, u, v, n);
H3 = notchFilter(0.1, 0.15, -0.15, u, v, n);
H4 = notchFilter(0.15, 0.28, -0.28, u, v, n); 

removed = H1.*H2;
removed = removed .* H3;
removed = removed .* H4; 
removed = removed.*img_fftsh;

figure;
set(gcf, 'Name', 'Ruido periodico removido de 4 componentes pares', 'NumberTitle', 'Off');

subplot(2,2,1); imshow(img, []); title('Original');
subplot(2,2,2); imshow(log(abs(img_fftsh.^0.55)+1), []); title('Espectro');
subplot(2,2,3); imshow(ifft2(ifftshift(removed)), []); title('Imagen con filtro');
subplot(2,2,4); imshow(log(abs(removed.^0.55)+1), []); title('Espectro con filtro');

pause;
% Basket
clc; clear;

img = imread('basket.tif');
img_gray = mat2gray(double(img));
img_fft = fft2(img_gray);
img_fftsh = fftshift(img_fft);

[ix, iy] = size(img_fftsh);

% Filter
% TODO: Checar si es el tamaño es par, dejar impar
vx = -1:1/((ix-1)/2):1; 
vy = -1:1/((iy-1)/2):1;

[mx, my] = meshgrid(vy, vx);

% Overall values
n = 40; u = mx; v = my;

% Compute all the given values to any notch in the spectrum
% The values are taken from the spectrum. 

H1 = notchFilter(0.09, 0.12, 0.75, u, v, n);
H2 = notchFilter(0.1, 0.78, -0.16, u, v, n);
H3 = notchFilter(0.17, 0.08, -0.52, u, v, n);
H4 = notchFilter(0.2, -0.12, 0.59, u, v, n); 
H5 = notchFilter(0.22, 0.6, 0.12, u, v, n);
H6 = notchFilter(0.22, 0.55, -0.1, u, v, n);
H7 = notchFilter(0.2, 0.49, 0.05, u, v, n);
H8 = notchFilter(0.15, 0.74, 0.25, u, v, n);
H9 = notchFilter(0.17, -0.099, -0.53, u, v, n);

re = H1 .* H2;
re = re .* H3;
re = re .* H4;
re = re .* H5; 
re = re .* H6; 
re = re .* H7; 
re = re .* H8;
re = re .* H9;

re = re.*img_fftsh;

figure;
set(gcf, 'Name', 'Basket con componentes removidos', 'NumberTitle', 'Off')

subplot(2,2,1); imshow(img, []); title('Original');
subplot(2,2,2); imshow(log(abs(img_fftsh.^0.55)+1), []); title('Espectro');
subplot(2,2,3); imshow(abs(ifft2(ifftshift(re))+1), []); title('Con patrones removidos');
subplot(2,2,4); imshow(log(abs(re.^0.55)+1), []); title('Espectro con componentes removidos');

disp('Parte 4');
disp('Como se puede apreciar en los espectros se muestran deltas muy pronunciadas, que pueden ser tapadas a través de los filtros de notch.');
disp('Lo que puede resultar algo complicado son las coordenadas y la densidad con la que se aplicaría dicho filtro.');
pause;
close all;
