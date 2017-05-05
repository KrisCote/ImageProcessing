function [ img ] = imcircle( r, w, dim ) 
%IMCIRCLE outputs an array of size dim with a circle of 1 values.
%   r: circle radius
%   w: fill of circle drawn with ones (1% is a line, 100% is a disk)
%   dim: 2 element vector of x and y size of resulting image 

img=zeros(dim(1),dim(2));
for i=1:dim(1)
    for j=1:dim(2)
       if and(r^2 > ((i-dim(1)/2)^2+(j-dim(2)/2)^2)*(1-w),...
               r^2 < ((i-dim(1)/2)^2+(j-dim(2)/2)^2)*1)
           img(i,j)=1;
       end
    end
end

end
