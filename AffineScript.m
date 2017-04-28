clear all;
close all;
clc;

% ************************************************************************
% Kris Cote
% BEE 515
% Generate various versions of img by applying different affine
% transformations.
% ************************************************************************

img=checkerboard(20);

figure(1)
imshow(img,[])
title('Identity (Original)')

mag=[1,0];
X=affine(img,'reflect',mag,'nearest',0);

figure(2)
imshow(X,[])
title('Reflected Horizontaly')


mag=[2,1];
X=affine(img,'scale',mag,'nearest',0);

figure(3)
imshow(X,[])
title('Scaled 2x Horizontaly')

%  Shear 
mag=[0.5,0];
X=affine(img,'shear',mag,'nearest',0);

figure(4)
imshow(X,[])
title('Sheared Horizontaly')

%  Shear 
mag=[pi()/4,0];
X=affine(img,'rotate',mag,'nearest',0);

figure(5)
imshow(X,[])
title('rotated by \pi/4')
