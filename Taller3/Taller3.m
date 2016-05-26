
%o1 = sqrt(2/Tsim)*cos(2*pi*fc*t);
%02 = -sqrt(2/Tsim)*cos(2*pi*fc*t);
tb = 0.003;  

%%% Parte 2: Secuencias de bit de entrada %%%
imagen = imread('Super_Mario.jpg');
Ximg = im2bw(imagen,0.5);
%imshow(imagen);
imshow(Ximg);
ximg = reshape(Ximg, [1,307200]);

%%%Parte 3: Modulación 16-QAM banda-base %%%
M = 16 %Simbolos poosibles
b = 4 %bits por simbolo
Tsim = b*tb;

