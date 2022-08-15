% Two Channel implementation of the LMS algorithm
clear all;close all;
sigfile='abc.wav'; % Read the recorded signal
noisefile='noise.wav'; % Read the recorded noise
[sig_noise,fs_sig,nbits_sig,refnoise]=sig_plus_noise(sigfile,noisefile); % Generate a synthetic noise from this reference noise,mix it with signal, and return the mixed file
file_len=length(sig_noise); % Length of the file
L=input('Enter the order of the reconstruction filter: '); % Order of the filter
e=zeros(file_len,1); % Put place-holder zeros for error vector
w=zeros(L,1); % Put place-holder zeros for weight vector
eta=input('Enter the learning rate for LMS: '); % Gain constant that regulates the speed and stability of adaptation
for i=L+1:file_len
e(i)=sig_noise(i)-refnoise(i-L+1:i)'*w; % Calculation of Error vector
w=w+2*eta*e(i)*refnoise(i-L+1:i); % Calculation of the Weight vector
end;
subplot(311);
plot(sig_noise); title('Signal plus noise');
subplot(312);
plot(refnoise); title('Reference noise');
subplot(313);
plot(e); title('Reconstructed output');
echo on;
% The final values of converged w of the filter:
echo off;

wavwrite(e,fs_sig,nbits_sig,'restored.wav') % Write the outputsignal to a music file