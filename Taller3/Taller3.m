
Tb = 0.003;
Tsim = 4*Tb;
%f1 = sqrt(2/Tsim)*cos(2*pi*fc*t);
%f2 = -sqrt(2/Tsim)*cos(2*pi*fc*t);


%%% Parte 2: Secuencias de bit de entrada %%%
imagen = imread('Charmander.png');
Ximg = im2bw(imagen, 0.35);
imshow(Ximg);

%%%Parte 3: Modulación 16-QAM banda-base %%%
ximg = reshape(Ximg,307200/4,4); 
xsimb = bi2de(ximg);   

figure; 
stem(xsimb(1:250));
title('Primeros simbolos transmitidos');
xlabel('Symbol Index');
ylabel('Integer Value');
legend('xsimb');

dataMod = qammod(xsimb,16,0,'gray');
scatterplot(dataMod,1,0,'k*')
REAL = real(dataMod);
figure;
stem(REAL(1:600));
title('Señal X_I');
xlabel('Symbol Index');
ylabel('Integer Value');
IMG = imag(dataMod);
figure;
stem(IMG(1:600));
title('Señal X_Q');
xlabel('Symbol Index');
ylabel('Integer Value');
%%%Parte 4: Canal AWGN banda-base %%%
snr = 15; %SNR en dB
rsimb = awgn(dataMod,snr,'measured');
REAL2 = real(rsimb);
figure;
stem(REAL2(1:600));
title('Señal X_I*');
xlabel('Symbol Index');
ylabel('Integer Value');
IMG2 = imag(rsimb);
figure;
stem(IMG2(1:600));
title('Señal X_Q*');
xlabel('Symbol Index');
ylabel('Integer Value');

sPlotFig = scatterplot(rsimb,1,0,'g.');
hold on
scatterplot(dataMod,1,0,'k*',sPlotFig)

%%%Parte 5: Demodulación 16-QAM banda-base %%%
ysimb = qamdemod(rsimb,16,0,'gray'); %obtengo los simbolos en el demodulador
figure;
comp=[xsimb(800:1050),ysimb(800:1050)];
stem(comp,'filled');
title('Primeros simbolos demodulados');
xlabel('Symbol Index');
ylabel('Integer Value');

yimg = de2bi(ysimb); %obtengo los binarios correspondientes por simbolo

[numErrors,ber] = biterr(ximg,yimg); %numero de errores
fprintf('\nSe tiene un BER = %d, con %d errores\n', ber*100,numErrors);

[m,n] = size(Ximg);
Yimg = reshape(yimg,m,n); %Redimensionamiento para crear imagen
figure;
imshow(Yimg); %imagen demodulada

%%%Parte 6: Medidas de desempeño %%%
snr0 = 0; %SNR en dB
rsimb0 = awgn(dataMod,snr0,'measured');
ysimb0 = qamdemod(rsimb0,16,0,'gray'); %obtengo los simbolos en el demodulador
yimg0 = de2bi(ysimb0); %obtengo los binarios correspondientes por simbolo
[numErrors0,ber0] = biterr(ximg,yimg0); %numero de errores

snr5 = 5; %SNR en dB
rsimb5 = awgn(dataMod,snr5,'measured');
ysimb5 = qamdemod(rsimb5,16,0,'gray'); %obtengo los simbolos en el demodulador
yimg5 = de2bi(ysimb5); %obtengo los binarios correspondientes por simbolo
[numErrors5,ber5] = biterr(ximg,yimg5); %numero de errores


snr10 = 10; %SNR en dB
rsimb10 = awgn(dataMod,snr10,'measured');
ysimb10 = qamdemod(rsimb10,16,0,'gray'); %obtengo los simbolos en el demodulador
yimg10 = de2bi(ysimb10); %obtengo los binarios correspondientes por simbolo
[numErrors10,ber10] = biterr(ximg,yimg10); %numero de errores


snr15 = 15; %SNR en dB
rsimb15 = awgn(dataMod,snr15,'measured');
ysimb15 = qamdemod(rsimb15,16,0,'gray'); %obtengo los simbolos en el demodulador
yimg15 = de2bi(ysimb15); %obtengo los binarios correspondientes por simbolo
[numErrors15,ber15] = biterr(ximg,yimg15); %numero de errores

snr20 = 20; %SNR en dB
rsimb20 = awgn(dataMod,snr20,'measured');
ysimb20 = qamdemod(rsimb20,16,0,'gray'); %obtengo los simbolos en el demodulador
yimg20 = de2bi(ysimb20); %obtengo los binarios correspondientes por simbolo
[numErrors20,ber20] = biterr(ximg,yimg20); %numero de errores

snr25 = 25; %SNR en dB
rsimb25 = awgn(dataMod,snr25,'measured');
ysimb25 = qamdemod(rsimb25,16,0,'gray'); %obtengo los simbolos en el demodulador
yimg25 = de2bi(ysimb25); %obtengo los binarios correspondientes por simbolo
[numErrors25,ber25] = biterr(ximg,yimg25); %numero de errores

snr30 = 30; %SNR en dB
rsimb30 = awgn(dataMod,snr30,'measured');
ysimb30 = qamdemod(rsimb30,16,0,'gray'); %obtengo los simbolos en el demodulador
yimg30 = de2bi(ysimb30); %obtengo los binarios correspondientes por simbolo
[numErrors30,ber30] = biterr(ximg,yimg30); %numero de errores

x=[0,5,10,15,20,25,30];
BER=[ber0,ber5,ber10,ber15,ber20,ber25,ber30]*100;
figure;
stem(x,BER,'filled');
title('Porcentaje de bits erroneos según el SNR');
ylabel('Ber (%)');
xlabel('SNR (dB)');
