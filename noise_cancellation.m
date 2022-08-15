
clear all;
[sig,fsd,nbitsd]=wavread('abc_noise.wav'); % Reading music file with a noise
sig2=sig(1:1000000,1); % Processing only first 1000000 samples to reduce the time
ylen=length(sig2);
d=250; % Large delay to make noise uncorrelated as possible
sig_del=zeros(ylen,1);%initializing delay signal
sig_del(d:ylen)=sig2(1:ylen-d+1); % Delayed signal
e=zeros(ylen,1);
w=zeros(ylen,1);
w1=zeros(ylen,1);
L=151; % Filter order
mu=0.0005; % convergence rate
for i=L+1:ylen
e(i)=sig2(i)-transpose(sig_del(i-L+1:i))*w(i-L+1:i); %Calculation of Error
w(i-L+2:i+1)=w(i-L+1:i)+2*mu*e(i)*sig_del(i-L+1:i); %Calculation of the Weight vector
w1(i)=transpose(sig_del(i-L+1:i))*w(i-L+1:i); % Output signal of our code
end;
subplot(411);
plot(sig2); 
title('Signal');
subplot(412);
plot(sig_del); 
title('Delayed signal');
subplot(413);
plot(e); 
title('Error');
subplot(414);
plot(w1); 
title('Restored signal');
echo on;
%complete!
echo off;
%w1=w1/max(abs(max(w1)),abs(min(w1))); % Normalization of output to prevent data clipping
wavwrite(w1,fsd,nbitsd,'desired_signal.wav'); % Write the output signal 