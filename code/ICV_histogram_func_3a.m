 function ICV_history = ICV_histogram_func_3a(img)

MainImg = size(img);

%assigns each channel as well as its rows and columns to a variable
Rimg = img(:,:,1);
Gimg = img(:,:,2);
Bimg = img(:,:,3);

% creates an array of 'zeros' from 1 to 256 to store the mode of  different value
% intensities over time
rIndex = zeros(1,256);
gIndex = zeros(1,256);
bIndex = zeros(1,256);

for rowA = 1:MainImg(1)
    
    for colB = 1:MainImg(2) 
        
    Ri = uint16(Rimg(rowA, colB));
    Gi = uint16(Gimg(rowA, colB));
    Bi = uint16(Bimg(rowA, colB));  
    % increases the index value of the various containers everytime a
    % identical value is encountered
    rIndex(Ri +1) = rIndex(Ri +1) + 1;
    gIndex(Gi +1) = gIndex(Gi +1) + 1;
    bIndex(Bi +1) = bIndex(Bi +1) + 1;
        
        
    end
    
end

ICV_history = [rIndex;gIndex;bIndex];

 end
