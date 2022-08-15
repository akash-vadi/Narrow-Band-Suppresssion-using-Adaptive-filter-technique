N=5000; %no of samples 
n= -N/2:N/2-1;
w0=0.25;
% r=0.4; %frequency of narrowband
phi=0;
A=0.12; %amplitude considering power criteria Ps = 10Pw
sn=A*(sin(2*pi*n*w0+phi)+sin(2*pi*n*r+phi));
a= -0.006;
b= 0.006;
                      %band limited uniformly distributed signal considering power criteria
wn=a+(b-a).*rand(N,1);
x=sn'+wn;
d=1;
len=length(x);
x_d=zeros(len,1);
x_d(d:len)=x(1:len-d+1); %delayed signal
e=zeros(len,1);w=zeros(len,1);L=10;
w1=zeros(len,1);
mu=0.0000000126263; %step size considering power and length of filter

for i=L+1:len
e(i)=x(i)-transpose(x_d(i-L+1:i))*w(i-L+1:i); %Calculation of Error
w(i-L+2:i+1)=w(i-L+1:i)+2*mu*e(i)*x_d(i-L+1:i); %Calculation of the Weight vector
w1(i)=transpose(x_d(i-L+1:i))*w(i-L+1:i); % Output signal of our code
end;


% subplot(411);
% plot(wn); title('wideband signal');
% subplot(412);
% plot(sn); title('narrowband signal');
% % subplot(211); 
y=fft(sn,N);
m=abs(y);
y(m<1e-6) =0;
f=(0:length(y)-1)*100/length(y);
subplot(4,1,1);
plot(f,m); title('Frequency Response of NarrowBand Signal');
y1=fft(wn,N);
m1=abs(y1);
y1(m1<1e-6) =0;
f1=(0:length(y1)-1)*100/length(y1);
subplot(4,1,2);
plot(f1,m1); title('Frequency Response of WideBand Signal');
y2=fft(w1,N);
m2=abs(y2);
y2(m2<1e-6) =0;
f2=(0:length(y2)-1)*100/length(y2);
subplot(4,1,3);
plot(f2,m2); title('Frequency Response of Resultant Signal');
y3=1-y2;
m3=abs(y3);
y3(m3<1e-6) =0;
f3=(0:length(y3)-1)*100/length(y3);
subplot(4,1,4);
plot(f3,m3); title('Frequency Response of Suppression Filter');
