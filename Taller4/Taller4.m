%%% Parte 1: Secuencias de bit de entrada %%%
imagen = imread('pokemon.jpg');
figure(1)
imshow('pokemon.jpg')
Ximg = im2bw(imagen, 0.6);
figure(2)
imshow(Ximg);
ximg = reshape(Ximg,1,126000);%Se crea un uunico vector que contiene toda la info de la imagen

%%% Parte 2: Modelo de canal
blocks = reshape(ximg,18000,7);%Se crea una matriz de 18000x7 a partir del vector ximg
error = randerr(18000,7,[0 1]); %Se crea una matriz de error 18000x7 
noise_blocks = blocks + error; %se suman la matriz de bloques maas la matriz de error

for i = 1:7
    for j = 1:18000
        Vx(j,i) = rem(noise_blocks(j,i),2); %rem devuelve el reciduo de la division de cada numero entre 2 de modo que sirve pare recuperar la matriz obtenida de la suma binaria
    end
end

yimg = reshape(Vx,1,126000); %Se recrea un vector grande a partir de Vx

berr = 0;
%Se cuenta la cantidad de errores producidos en la imagen por el canal
for i = 1:126000
    bit_diff = ximg(1,i)-yimg(1,i);
    if bit_diff ~= 0
        berr = berr + 1;
    end
end

berr

Yimg = reshape(yimg,300,420);%Se recupera la imagen transmitida
figure(3)
imshow(Yimg);

% Parte 3: Codificacioon lineal de bloques
k = 4;
n = 7;
R = 4/7;
u = n-k;
%Matriz generadora
[h,G] = hammgen(u);

