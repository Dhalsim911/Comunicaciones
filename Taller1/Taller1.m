%%%   Definicion de variables publicas %%%%
syms t1
A1 = 0.7;
A2 = 0.3;
A3 = 0.4;
f1 = 370;
f2 = 3*f1;
f3 = 5*f1;
T1 = 1/f1;
T2 = 1/f2;
T3 = 1/f3;
FS = 32*f1;
N = 256;
fin =((N-1)/FS);
itv = 1/FS;
t = (0:itv:fin).';

%%%%%       Parte 1: Estudio Preliminar
% Calculo y plot de x(t)
x = A1*cos(2*pi*f1*t) + A2*sin(2*pi*f2*t) + A3*cos(2*pi*f3*t);
figure (1);
plot(t,x);
xlabel('tiempo (s)');
ylabel('Amplitud');
legend('x(t)');

%Calculo de la potencia promedio Px(t)
x1 = A1*cos(2*pi*f1*t1);
x2 = A2*sin(2*pi*f2*t1);
x3 = A3*cos(2*pi*f3*t1);

P1 = (1/T1)*(int(x1^2,0,T1));
P2 = (1/T2)*(int((x2)^2,0,T2));
P3 = (1/T3)*(int((x3)^2,0,T3));
%Por superposicion calculo Px
Px = P1 + P2 + P3

%%%%%       Parte 2: Transformada de Fourier
X = 1/N*fftshift(fft(x,N));

%%%%%       Parte 3: Densidad Espectral de Potencia
Sxx = periodogram(x,rectwin(N),N,FS,'onesided');
