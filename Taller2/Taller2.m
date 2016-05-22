%%% Definicion de variables publicas %%%
A1 = 0.7;
A2 = 0.3;
A3 = 0.4;
f = 370;
f2 = 3*f;
f3 = 5*f;
fc = 38000;
FS = 4*fc;
N = 8192;
fin = ((N-1)/FS);
paso = 1/FS;  
%paso = 1/(100*FS);%Resolucion mejorada, usar solo para graficar la sennal portadora
t = (0:paso:fin).';
inicio_vf = -FS/2;
fin_vf = FS/2-FS/N;
paso_vf = FS/N;
VF = (inicio_vf:paso_vf:fin_vf).';

%%%% Parte 1: Sennal portadora y moduladora %%%%
c = cos(2*pi*fc*t);
x = A1*cos(2*pi*f*t) + A2*sin(2*pi*3*f*t) + A3*cos(2*pi*5*f*t);
figure(1);
plot(t,c);
xlabel('Tiempo (s)');
ylabel('Amplitud');
legend('c(t)');

figure(2);
plot(t,x);
xlabel('Tiempo (s)');
ylabel('Amplitud');
legend('x(t)');

C = 1/N*fftshift(fft(c,N));
REAL_C = real(C);
IMAG_C = imag(C);
MAG_C=abs(C);
figure (3);
stem(VF,MAG_C);
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
legend('|C(f)|');

X = 1/N*fftshift(fft(x,N));
REAL_X = real(X);
IMAG_X = imag(X);
MAG_X=abs(X);
figure (4);
stem(VF,MAG_X);
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
legend('|X(f)|');

%%%% Parte 2: Modulacioon AM convencional %%%$
x1 = (1 + x);
s = x1.*c;
figure(5);
plot(t,s);
xlabel('Tiempo (s)');
ylabel('Amplitud');
legend('Señal modulada s(t)');

S = 1/N*fftshift(fft(s,N));
REAL_S = real(S);
IMAG_S = imag(S);
MAG_S=abs(S);
figure (6);
stem(VF,MAG_S);
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
legend('|S(f)|');

sb = 2*x1.*c;
xc = 3*x1;
cc = 4*c;
sc = xc.*cc;
figure(7);
subplot(3,1,1)
plot(t,s);
xlabel('Tiempo (s)');
ylabel('Amplitud');
legend('s(t)');
subplot(3,1,2)
plot(t,sb);
xlabel('Tiempo (s)');
ylabel('Amplitud');
legend('s_b(t)');
subplot(3,1,3)
plot(t,sc);
xlabel('Tiempo (s)');
ylabel('Amplitud');
legend('s_c(t)');

%%%% Parte 3: Modulación AM DSB-SC %%%%
s2 = x.*c;
figure(5);
plot(t,s2);
xlabel('Tiempo (s)');
ylabel('Amplitud');
legend('Señal modulada s2(t)');

S2 = 1/N*fftshift(fft(s2,N));
REAL_S2 = real(S2);
IMAG_S2 = imag(S2);
MAG_S2=abs(S2);
figure(8);
stem(VF,MAG_S2);
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
legend('|S2(f)|');

%%%% Parte 4: Demodulación AM DSB-SC %%%%
y1 = s.*c;
D = designfilt('lowpassfir','FilterOrder',32,'HalfPowerFrequency',fc,'SampleRate',FS);
y1 = filter(D,y1);
y1 = 2*y1;
y2 = s2.*c;
y2 = filter(D,y2);
y2 = 2*y2;
figure(9);
subplot(2,1,1)
plot(t,y1);
xlabel('Tiempo (s)');
ylabel('Amplitud');
legend('y_1^*(t)');
subplot(2,1,2)
plot(t,y2);
xlabel('Tiempo (s)');
ylabel('Amplitud');
legend('y_2^*(t)');

Y1 = 1/N*fftshift(fft(y1,N));
REAL_Y1 = real(Y1);
IMAG_Y1 = imag(Y1);
MAG_Y1=abs(Y1);
figure(10);
stem(VF,MAG_Y1);
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
legend('|Y1(f)|');

Y2 = 1/N*fftshift(fft(y2,N));
REAL_Y2 = real(Y2);
IMAG_Y2 = imag(Y2);
MAG_Y2=abs(Y2);
figure(11);
stem(VF,MAG_Y2);
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
legend('|Y2(f)|');