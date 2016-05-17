%%%   Definicion de variables publicas %%%%
syms t1
A1 = 0.7;
A2 = 0.3;
A3 = 0.4;
f = 370;
f2=3*f;
T = 1/f;
FS = 32*f;
N = 256;
fin =((N-1)/FS);
itv = 1/FS;
t = (0:itv:fin).';

%%%%%       Parte 1: Estudio Preliminar
% Calculo y plot de x(t)
x = A1*cos(2*pi*f*t) + A2*sin(2*pi*3*f*t) + A3*cos(2*pi*5*f*t);
figure (1);
plot(t,x);
xlabel('tiempo (s)');
ylabel('Amplitud');
legend('x(t)');

%Calculo de la potencia promedio Px(t)
x1 = A1*cos(2*pi*f*t1);
x2 = A2*sin(2*pi*3*f*t1);
x3 = A3*cos(2*pi*5*f*t1);
P = mean(x.^2)
P1 = (1/T)*(int(x1^2,0,T));
P2 = (1/T)*(int((x2)^2,0,T));
P3 = (1/T)*(int((x3)^2,0,T));
Px = P1 + P2 + P3

%%%%%       Parte 2: Transformada de Fourier
X = 1/N*fftshift(fft(x,N));
inicio=-FS/2;
paso= FS/N;
final=FS/2-FS/N;
VF= (inicio:paso:final).';
REAL=real(X);
IMAG=imag(X);

figure (2);
%plot(VF,REAL);
stem(VF,REAL);
xlabel('Frecuencia (Hz)');
ylabel('Re(X(f))');

figure (3);
%plot(VF,IMAG);
stem(VF,IMAG);
xlabel('Frecuencia (Hz)');
ylabel('Img (X(f))');

MAG=abs(X);
figure (4);
%plot(VF,IMAG);
stem(VF,MAG);
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
legend('|X(f)|');


%%%%%       Parte 3: Densidad Espectral de Potencia
Sxx = periodogram(x,rectwin(N),N,FS,'onesided');
Sxx = FS/N*Sxx(1:N/2)';
SxxdB = 10*log10(Sxx); 
VF2= (0:paso:final).';
figure (5);
%length(VF2)
%length(SxxdB)
plot(VF2,SxxdB);
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (dB)');
legend('Sxx');

Px = sum(Sxx)

Sxx1 = 2*abs(X(N/2+1:N)).^2;
Px1 = sum(Sxx1)
Sxx1dB = 10*log10(Sxx1);
figure (6);
plot(VF2,Sxx1dB);
xlabel('Frecuencia (Hz)');
ylabel('Amplitud (dB)');
legend('Sxx1');
%%%%%       Parte 4: Filtrado
D = designfilt('lowpassfir','FilterOrder',32,'HalfPowerFrequency',f2,'SampleRate',FS);
[h,w] = freqz(D,N,FS);
figure (7);
h1 = abs(h);
hdB = 10*log10(h1);
freq = w/(2*pi);
plot(w,h1);
xlabel('Frecuencia (Hz)');
ylabel('Amplitud');
legend('H(f)');
y = filtfilt(D,x); 
y1 = filter(D,x);
Y = 1/N*fftshift(fft(y,N));
figure (8);
stem(VF,abs(Y));
xlabel('frecuencia (Hz)');
ylabel('Amplitud ');
legend('Y(f)');
