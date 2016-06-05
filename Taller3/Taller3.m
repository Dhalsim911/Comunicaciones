
Tb = 0.003;
Tsim = 4*Tb;
%f1 = sqrt(2/Tsim)*cos(2*pi*fc*t);
%f2 = -sqrt(2/Tsim)*cos(2*pi*fc*t);


%%% Parte 2: Secuencias de bit de entrada %%%
imagen = imread('Charmander.png');
Ximg = im2bw(imagen, 0.5);
%imshow(imagen);
imshow(Ximg);
ximg = reshape(Ximg, [1,307200]);

%%%Parte 3: Modulación 16-QAM banda-base %%%
%M = 16 %Simbolos poosibles
%b = 4 %bits por simbolo
%Tsim = b*tb;
h = modem.qammod('M', 16, 'SymbolOrder', 'Gray', 'InputType', 'Bit')
y = modulate(Ximg,10,100,'qam')
