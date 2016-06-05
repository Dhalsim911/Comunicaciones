
Tb = 0.003;
Tsim = 4*Tb;
%f1 = sqrt(2/Tsim)*cos(2*pi*fc*t);
%f2 = -sqrt(2/Tsim)*cos(2*pi*fc*t);


%%% Parte 2: Secuencias de bit de entrada %%%
imagen = imread('Charmander.png');
Ximg = im2bw(imagen, 0.5);
%imshow(imagen);
imshow(Ximg);
ximgvector = reshape(Ximg, [1,307200]);

%%%Parte 3: Modulación 16-QAM banda-base %%%
ximg = reshape(Ximg,307200/4,4); 
xsimb = bi2de(ximg);   
%h = modem.qammod('M', 16, 'SymbolOrder', 'Gray', 'InputType', 'Bit')
%y = modulate(Ximg,10,100,'qam')
figure; % Create new figure window.
stem(xsimb(1:250));
title('Primeros simbolos transmitidos');
xlabel('Symbol Index');
ylabel('Integer Value');

dataMod = qammod(xsimb,16,0,'gray');
scatterplot(dataMod,1,0,'k*')

%%%Parte 4: Canal AWGN banda-base %%%
snr = 25; %SNR en dB
rsimb = awgn(dataMod,snr,'measured');

%figure; % Create new figure window.
%stem(rsimb(1:250));
%title('Primeros simbolos recibidos');
%xlabel('Symbol Index');
%ylabel('Integer Value');

sPlotFig = scatterplot(rsimb,1,0,'g.');
hold on
scatterplot(dataMod,1,0,'k*',sPlotFig)

%%%Parte 5: Demodulación 16-QAM banda-base %%%
ysimb = qamdemod(rsimb,16,0,'gray');
yimg = dec2bin(ysimb,4);
yimgvector = reshape(yimg, [1,307200]);

[numErrors,ber] = biterr(ximgvector,yimgvector);
fprintf('\nThe binary coding bit error rate = %5.2e, based on %d errors\n', ber,numErrors);

[m,n] = size(Ximg)
Yimg = reshape(yimg,m,n);
%A = logical(Yimg);
%image(Yimg);


