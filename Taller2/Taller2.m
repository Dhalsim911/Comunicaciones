%%% Definicion de variables publicas %%%
A1 = 0.7;
A2 = 0.3;
A3 = 0.4;
f = 370;
f2 = 3*f;
f3 = 5*f;
fc = 38000;
m1 = 0.5,
m2 = 0.1;
m3 = 0.9;
FS = 4*fc;
N = 8192;
fin = ((N-1)/FS);
paso = 1/FS;  
%paso = 1/(100*FS);%Resolucion mejorada, usar solo para graficar la senal portadora
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
ylabel('Señal portadora');
legend('c(t)');

figure(2);
plot(t,x);
xlabel('Tiempo (s)');
ylabel('Señal moduladora');
legend('x(t)');

C = 1/N*fftshift(fft(c,N));
MAG_C=abs(C);
figure (3);
stem(VF,MAG_C);
xlabel('Frecuencia (Hz)');
ylabel('Señal portadora');
legend('|C(f)|');

X = 1/N*fftshift(fft(x,N));
MAG_X=abs(X);
figure (4);
stem(VF,MAG_X);
xlabel('Frecuencia (Hz)');
ylabel('Señal moduladora');
legend('|X(f)|');

%%%% Parte 2: Modulacioon AM convencional %%%$
x1 = (1 + m1*x);
s = x1.*c;
figure(5);
plot(t,s);
xlabel('Tiempo (s)');
ylabel('Amplitud');
legend('Señal modulada s(t)');

S = 1/N*fftshift(fft(s,N));
MAG_S=abs(S);
figure (6);
stem(VF,MAG_S);
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
legend('|S(f)|');

x2 = (1 + m2*x);
sb = x2.*c;
x3 = (1 + m3*x);
sc = x3.*c;
figure(7);
subplot(3,1,1)
plot(t,s);
xlabel('Tiempo (s)');
ylabel('Amplitud');
legend('s(t), m=0.5');
subplot(3,1,2)
plot(t,sb);
xlabel('Tiempo (s)');
ylabel('Amplitud');
legend('s_b(t), m=0.1');
subplot(3,1,3)
plot(t,sc);
xlabel('Tiempo (s)');
ylabel('Amplitud');
legend('s_c(t), m=0.9');

%%%% Parte 3: Modulación AM DSB-SC %%%%
s2 = x.*c;
figure(5);
plot(t,s2);
xlabel('Tiempo (s)');
ylabel('Amplitud');
legend('Señal modulada s2(t)');

S2 = 1/N*fftshift(fft(s2,N));
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
MAG_Y1=abs(Y1);
figure(10);
stem(VF,MAG_Y1);
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
legend('|Y1(f)|');

Y2 = 1/N*fftshift(fft(y2,N));
MAG_Y2=abs(Y2);
figure(11);
stem(VF,MAG_Y2);
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
legend('|Y2(f)|');
