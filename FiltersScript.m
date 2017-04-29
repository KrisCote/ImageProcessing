clear all;
close all;
clc;

% ************************************************************************
% Kris Cote
% BEE 515
% Digital Image Processing Applications
%
% Generate various versions of img by applying high and low pass spatial
% and frequency domain filters.
% ************************************************************************

img=checkerboard(20);                           % generate checkerboard
                                                % test image
[m,n]=size(img);                                % get size of image

figure(1)
imshow(img,[])                                  % show original test image
title('Original')

% *************************************************************************
% **************************  SPATIAL DOMAIN  *****************************

kmean=1/9*[1 1 1; 1 1 1; 1 1 1];                % mean blur filter kernel
klaplace=[0 -1 0; -1 4 -1; 0 -1 0];             % Laplacian filter kernel

%  ********************  LOWPASS SPATIAL DOMAIN ***************************
X=conv2(img,kmean);                             % convolve test img with
                                                % 3x3 mean filter kernel
figure(2)
imshow(X,[])                                    % show mean filtered img
title('3 \times 3 Mean Blur')

%  ********************  HIGHPASS SPATIAL DOMAIN **************************
X=conv2(img,klaplace);                          % convolve test img with
                                                % 3x3 Laplacian kernel
figure(3)
imshow(X,[])                                    % show Laplacian filtered 
title('Laplacian Edge Detection')

% *************************************************************************
% **************************  FOURIER DOMAIN  *****************************

pad=paddedsize([m,n]);                          % get padding size
imgp=padarray(img,[pad(1),pad(2)],'both');      % set pad before & after
[p,q]=size(imgp);                               % get size of padded img
fftpad=fft2(imgp);                              % Fourier transform
F=fftshift(fftpad);                             % shift low freq to middle

Hlp=fftshift(lpfilter('btw',p,q,60));           % get butterworth filter
Hhp=1-Hlp;                                      % get highpass

figure(4)
imshow(log(1+abs(F)),[])                        % show frequency domain
title('FFT Representation')                     % represntation of test img

%  ********************  LOWPASS FOURIER DOMAIN ***************************
LPimg=abs(ifft2(F.*Hlp));                       % apply filter and IFFT
figure(5)
subplot(2,1,1)
imshow(Hlp,[])                                  % show the filter 
title('Lowpass Butterworth')
subplot(2,1,2)                                  % show result cropped
imshow(LPimg(round((p-n)/2):round(n+(p-n)/2),round((q-m)/2):round(m+(q-m)/2)),[])
title('FFT Lowpass Filtered')

%  ********************  HIGHPASS FOURIER DOMAIN **************************
HPimg=abs(ifft2(F.*Hhp));                       % apply filter and IFFT
figure(6)
subplot(2,1,1)
imshow(Hhp,[])                                  % show the filter 
title('Highpass Butterworth')
subplot(2,1,2)                                  % show result cropped
imshow(HPimg(round((p-n)/2):round(n+(p-n)/2),round((q-m)/2):round(m+(q-m)/2)),[])
title('FFT Highpass Filtered')
