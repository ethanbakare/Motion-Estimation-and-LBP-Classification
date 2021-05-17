function ICV_Non_overlap = ICV_Non_overlapping_Windows(MyFace,WindowDim)

% reads image and assign it to variable 'MyFace'
% MyFace = imread('/Users/ethan/Documents/MATLAB/second 181075578/Dataset (2)/DatasetA/face-2.jpg');

% converts image in variable 'MyFace' to greyscale and assigns it to
% 'MyFaceGrey'
MyFaceGrey = double(0.299 * MyFace(:,:,1) + 0.587 * MyFace(:,:,2) + 0.114 * MyFace(:,:,3));
MyFaceGrey = double(MyFaceGrey);

% assigns image in 'MyFaceGrey' to variable 'Non_Overlapping_Win'
Non_Overlapping_Win = MyFaceGrey;

% stores  total number of rows and column values matrice in 'myname' within ImgHeight and ImgWidth 
[ImgHeight,ImgWidth] = size(Non_Overlapping_Win);
% WindowDim = 64;
WindowNumber = (ImgHeight/WindowDim)^2; % Calculates number of Windows
WindowContainer = zeros(WindowDim,WindowDim,WindowNumber); % Creates an empty array of zeros with specific dimensions


% breaks images into seperate non overlapping windows
count = 1;
for i = 1:WindowDim:ImgHeight
    
    for j = 1:WindowDim:ImgWidth
        
        WindowContainer(:,:,count) = Non_Overlapping_Win(i:i+WindowDim-1,j:j+WindowDim-1);
        count = count+1;
    end
    
end

ICV_Non_overlap = uint8(WindowContainer);
% loops through the statement and incrementally prints all values in the
% 3rd dimension
end

    