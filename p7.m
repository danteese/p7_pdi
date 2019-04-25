%Dante Bazaldua Huerta
%Leonardo Alberto L?pez Romero
%Pr?ctica 7

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

%% Parte 3
figure
set(gcf, 'Name', '4 Bandas de rechazo', 'NumberTitle', 'Off');
fox=imread('fox.tif'); %leyendo imagen original
fox=mat2gray(double(fox));
foxFFT=fft2(fox); %trasnformada a frecuencia
foxFFT=fftshift(foxFFT);
%Creamos los vectores para crear los filtros
vectorX=-1:1/210:1;
vectorY=-1:1/319.5:1;
[xm,ym]=meshgrid(vectorY,vectorX);
%Creacion del primer filtro
H1=CrearFiltro(0.2, 1.3, xm, ym);
filtro1 = H1;
filtro1(421,640)= 0; %Creamos una delta en el centro
%Creacion del filtro 2
H2=CrearFiltro(0.18, 0.35, xm, ym);
filtro2 = H2;
filtro2(421,640)= 0;
%Creacion del filtro 3
H3=CrearFiltro(0.2, 0.75, xm, ym);
filtro3 = H3;
filtro3(421,640)= 0;
filtroTotal=filtro1.*filtro2.*filtro3;%Multiplicamos los filtros para hacer uno
filtroTotal=foxFFT.*filtroTotal; %multiplicamos en frecuencia
nuevaFox = ifftshift(filtroTotal);
nuevaFox=ifft2(nuevaFox);
%Ploteamos los resultados
subplot(2,2,1),imshow(fox),title('Imagen Original');
subplot(2,2,2),imshow((abs(foxFFT.^0.15)+1),[]),title('Espectro de imagen');
subplot(2,2,3),imshow((abs(filtroTotal.^0.15)+1),[]),title('Espectro con filtro');
subplot(2,2,4),imshow(abs(nuevaFox),[]),title('Imagen filtrada');
%% Funciones
%function [H]=CrearFiltro(W, Do, xm, ym)
%    D = sqrt((xm.^2)+(ym.^2)); %Do de la formula
%    H= 1./(1+(((D.*W)./(D.^2-(Do^2))).^2)); 
%end
