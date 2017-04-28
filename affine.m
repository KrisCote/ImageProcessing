function [ Y ] = affine(img, fxn, mag, interpolationMethod, invert)
%AFFINE apply affine transformations to input image
%   Y=AFFINE(image,transformation,magnitude,interpolation method)
%   img:    input image
%   fxn:    Transformation type: 'scale' (stretch in X & Y), 
%           rotate (rad clockwise), shear (in X OR Y), reflect (across X
%           and/or Y axis if mag(1)>0 and/or mag(2)>0 respectivly)
%   mag:    Magnitude of transformation, (2) element array, rotation needs
%           one element. 
%   method: Interpolation method string input(supports 'bicubic',
%           'bilinear', or 'nearest'
%   invert: If invert > 0, apply inverse transform

switch fxn                              % select which transform to use
    case 'scale'                            % X and Y scale
        T=[mag(1) 0 0; 0 mag(2) 0; 0 0 1];
    case 'rotate'                            % Rotation
        T=[cos(mag(1)) sin(mag(1)) 0; -sin(mag(1)) cos(mag(1)) 0; 0 0 1];
    case 'shear'
        T=[1 mag(2) 0; mag(1) 1 0; 0 0 1];
    case 'reflect'
        T=[1 0 0; 0 1 0; 0 0 1];
        if mag(1)>0
            T(1,1)=-1;
        end
        if mag(2)>0
            T(2,2)=-1;
        end
end

if invert>0                             % if invert > 0, invert T elements
    T=T^-1;
end

tform=maketform('affine',T);
Y=imtransform(img,tform,interpolationMethod);
end

