%o1 = sqrt(2/Tsim)*cos(2*pi*fc*t);
%02 = -sqrt(2/Tsim)*cos(2*pi*fc*t);

%%% Parte 2: Secuencias de bit de entrada %%%
imagen = imread('Super_Mario.jpg');
Ximg = im2bw(imagen,0.5);
%imshow(imagen);
imshow(Ximg);
ximg = reshape(Ximg, [1,307200]);
