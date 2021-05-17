%% AUTHOR - BABATUNDE BAKARE
% 181075578


 




%% QUESTION 4A
%MOTION VECTORS
tic;

clear all, clc, close all;

Vid_A = VideoReader('/Users/ethan/Documents/MATLAB/181075578/Dataset (2)/DatasetC.mpg');

VidFrame_A = read(Vid_A);% reads frames the video

PrevFrame = VidFrame_A(:,:,:,3);
NextFrame = VidFrame_A(:,:,:,4);

figure,imshow(PrevFrame);
figure,imshow(NextFrame);

WindowDim = 20;
BlockDim = 16;

M_Direction = ICV_GetMotionDirect(double(PrevFrame),double(NextFrame),BlockDim,WindowDim);
figure,imshow(NextFrame);
hold on;

CurrentBlock = 1;
Oldimg = size(PrevFrame);

for a = 1:BlockDim:Oldimg(1)-BlockDim +1
    for b = 1:BlockDim:Oldimg(2)-BlockDim +1
        quiver(a+(BlockDim/2)-1,+ b+(BlockDim/2)-1, M_Direction(2,CurrentBlock), M_Direction(1,CurrentBlock),'w');
        
        CurrentBlock = CurrentBlock +1;
    end
end

hold off;

toc;




%% QUESTION 4B,C,D

tic;

clear all, clc, close all;

Vid_A = VideoReader('/Users/ethan/Documents/MATLAB/181075578/Dataset (2)/DatasetC.mpg');

VidFrame_A = read(Vid_A);% reads frames the video

PrevFrame = VidFrame_A(:,:,:,90);
NextFrame = VidFrame_A(:,:,:,91);

figure,imshow(PrevFrame);
figure,imshow(NextFrame);

WindowDim = 32; %	%  ---------	---------	---------	---------	value to CHANGE
BlockDim = 8;% 	%  ---------	---------	---------	---------	value to CHANGE

M_Direction = ICV_GetMotionDirect(double(NextFrame),double(PrevFrame),BlockDim,WindowDim);
% makes an empty matrix for PriorImage
PriorImage = zeros(size(PrevFrame,1),size(PrevFrame,2),3); 

CurrentBlock = 1;
Oldimg = size(PrevFrame);

for a = 1:BlockDim:Oldimg(1)-BlockDim +1
    for b = 1:BlockDim:Oldimg(2)-BlockDim +1
         if a + BlockDim + M_Direction(2, CurrentBlock)<Oldimg(1) && b  + BlockDim + M_Direction(1, CurrentBlock)<Oldimg(2)
         PriorImage(a:a+BlockDim-1, b:b+BlockDim-1) = NextFrame(a + M_Direction(2, CurrentBlock): a+BlockDim + M_Direction(2, CurrentBlock) -1, b+ M_Direction(1, CurrentBlock): b+BlockDim + M_Direction(1, CurrentBlock) -1);
         
         end
        CurrentBlock = CurrentBlock +1;
    end
end
figure,imshow(uint8(PriorImage));
toc;


%% QUESTION 4E

%PLOTTING GRAPHS OF BLOCKS AND WINDOW



windows = [132.979383, 130.459620, 134.780321];
blocks = [35.60192, 128.443623, 486.040760];

figure,plot(1:3,blocks);
figure,plot(1:3,windows);






%% QUESTION 5A
% PIXEL BY PIXEL DIFFERENCING  
% calculates difference between reference image and all other frames in the
% sequence

% please check the 'imread' file path before running the section

clear all, clc, close all;

Vid_A = VideoReader('/Users/ethan/Documents/MATLAB/181075578/Dataset (2)/DatasetC.mpg');

VidFrame_A = read(Vid_A);% reads frames the video

% Convert video to greyscale
VidFrameGrey(:,:,1,:) = double(0.299 * VidFrame_A(:,:,1,:) + 0.587 * VidFrame_A(:,:,2,:) + 0.114 * VidFrame_A(:,:,3,:));
VidFrameGrey = double(VidFrameGrey);

% assigns first frame of video to variable 'ReferenceVidFrame'
ReferenceVidFrame = double(VidFrameGrey(:,:,:,1));

%
FrameResultSize = size(ReferenceVidFrame);

% creates an empty array 
FrameResult = zeros(FrameResultSize(1),FrameResultSize(2));




% loop iterativelly through the each frame of the video
for j = 2:Vid_A.NumFrames 
    
    CurrentFrame = double(VidFrameGrey(:,:,:,j));
    FrameDifference = abs(ReferenceVidFrame - CurrentFrame);
    FrameResult = FrameDifference > 40;
    
    
   
    subplot(1,2,1);
    imshow(uint8(ReferenceVidFrame));

    subplot(1,2,2);
    imshow(double(FrameResult));
    pause(1.5);
    
% %     drawnow();
%     imshow(double(FrameResult));

end

%% QUESTION 5B
% DIFFERENCING WITH CHANGING REFERENCE FRAMES

clear all, clc, close all;

Vid_A = VideoReader('/Users/ethan/Documents/MATLAB/181075578/Dataset (2)/DatasetC.mpg');

VidFrame_A = read(Vid_A);% reads frames the video


VidFrameGrey(:,:,1,:) = double(0.299 * VidFrame_A(:,:,1,:) + 0.587 * VidFrame_A(:,:,2,:) + 0.114 * VidFrame_A(:,:,3,:));
VidFrameGrey = double(VidFrameGrey);


VidFrame = double(VidFrameGrey);


FrameResult = [];


% loop iterativelly through the each frame of the video
for j = 1:Vid_A.NumFrames 
    if j < Vid_A.NumFrames 
        
    VidFrame = double(VidFrameGrey(:,:,:,j)); 
    CurrentFrame = double(VidFrameGrey(:,:,:,j+1));
    
    FrameDifference = abs(VidFrame - CurrentFrame);
    FrameResult = FrameDifference > 40;
    
    
   
    subplot(2,1,1);
    imshow(uint8(VidFrame));

    subplot(2,1,2);
    imshow(double(FrameResult));
    pause(.3);
    
% %     drawnow();
%     imshow(double(FrameResult));
    end
end


%% QUESTION 5C
% GENERATES A BACKGROUND IMAGE

clear all, clc, close all;

Vid_A = VideoReader('/Users/ethan/Documents/MATLAB/181075578/Dataset (2)/DatasetC.mpg');

VidFrame_A = read(Vid_A);% reads frames the video

RefFrameBackground = double(zeros(size(VidFrame_A(:,:,:,1),1), size(VidFrame_A(:,:,:,1),2),3)); % creates an empty array for the 


% loop iterativelly through the each frame of the video
for j = 1:Vid_A.NumFrames 
   
        
    CurrentFrame = double(VidFrame_A(:,:,:,j)); % obtains current frame via changing variable 'j'
    RefFrameBackground = RefFrameBackground + CurrentFrame;
        
end

RefFrameBackground(:,:,:) = double(RefFrameBackground(:,:,:)/Vid_A.NumFrames);

imshow(uint8(RefFrameBackground));






%% QUESTION 6A (i)
% GRAYSCALE NON-OVERLAPPING WINDOW FUNCTION
% Divides image into non overlapping windows


clear all, clc, close all; 

MyFace = imread('/Users/ethan/Documents/MATLAB/181075578/Dataset (2)/DatasetA/face-2.jpg');

WindowDim = 64;	%  ---------	---------	---------	---------	value to CHANGE

ICV_Non_overlap = ICV_Non_overlapping_Windows(MyFace,WindowDim);

 Non_overlap = ICV_Non_overlapping_Windows(MyFace,WindowDim);

for i = 1:size(ICV_Non_overlap,3)
     
    imshow(ICV_Non_overlap(:,:,i));
    pause(1);
    
    
end
 


%% QUESTION 6A (ii)
% LBP WINDOW FUNCTION
% Creates the LBP windows for all non-over lapping windows

% change the 'WindowDim' value to alter the size of the window

clear all, clc, close all; 

MyFace = imread('/Users/ethan/Documents/MATLAB/181075578/Dataset (2)/DatasetA/face-2.jpg');

WindowDim = 64;	%  ---------	---------	---------	---------	value to CHANGE


ICV_LBP_Win = ICV_LBP_Window(MyFace,WindowDim);


for i = 1:size(ICV_LBP_Win,3)
     
    imshow(ICV_LBP_Win(:,:,i));
    pause(1);
    
end

%% QUESTION 6A (iii)
% NORMALIZED HISTOGRAM FUNCTION

clear all, clc, close all; 

MyFace = imread('/Users/ethan/Documents/MATLAB/181075578/Dataset (2)/DatasetA/face-2.jpg');

WindowDim = 64;	%  ---------	---------	---------	---------	value to CHANGE

ICV_LBP_Win = ICV_LBP_Window(MyFace,WindowDim);

ICV_NormalizedHisto = ICV_NormalizedHistogram(ICV_LBP_Win, WindowDim);
% NormalizedHisto = ICV_NormalizedHistogram(ICV_LBP_Win, WindowDim);

for i = 1:size(ICV_NormalizedHisto,1)
     

    plot(0:255, ICV_NormalizedHisto(i,:));
    drawnow();
    pause(.5);
    
end




%% QUESTION 6B
% GLOBAL DESCRIPTOR
% please check the 'imread' file path before running the section


clear all, clc, close all;

MyFace = imread('/Users/ethan/Documents/MATLAB/181075578/Dataset (2)/DatasetA/face-2.jpg');

WindowDim = 128;	%  ---------	---------	---------	---------	value to CHANGE

ICV_LBP_Win = ICV_LBP_Window(MyFace,WindowDim);
ICV_NormalizedHisto = ICV_NormalizedHistogram(ICV_LBP_Win, WindowDim);


counter = 1;

    for z = 1:256:size(ICV_NormalizedHisto,1)*256 

             GlobalDesc(z:z+255) = ICV_NormalizedHisto(counter,:);
             counter = counter + 1;

    end

    plot(GlobalDesc);



%% QUESTION 6C,D,E
% CLASSIFIER
% please check the 'imread' file path before running the section
tic;
clear all, clc, close all;

TrainImg = imread('/Users/ethan/Documents/MATLAB/181075578/Dataset (2)/DatasetA/face-2.jpg');
TrainImg2 = imread('/Users/ethan/Documents/MATLAB/181075578/Dataset (2)/DatasetA/car-2.jpg');
TestImg = imread('/Users/ethan/Documents/MATLAB/181075578/Dataset (2)/DatasetA/car-1.jpg');

WindowDim = 64;	%  ---------	---------	---------	---------	value to CHANGE

ICV_LBP_Win = ICV_LBP_Window(TrainImg,WindowDim);
ICV_NormalizedHisto = ICV_NormalizedHistogram(ICV_LBP_Win, WindowDim);


counter = 1;

    for z = 1:256:size(ICV_NormalizedHisto,1)*256 

             GlobalDescTrain1(z:z+255) = ICV_NormalizedHisto(counter,:);
             counter = counter + 1;

    end

%     plot(GlobalDescTrain1);

    
    ICV_LBP_Win = ICV_LBP_Window(TrainImg2,WindowDim);
ICV_NormalizedHisto = ICV_NormalizedHistogram(ICV_LBP_Win, WindowDim);


counter = 1;

    for z = 1:256:size(ICV_NormalizedHisto,1)*256 

             GlobalDescTrain2(z:z+255) = ICV_NormalizedHisto(counter,:);
             counter = counter + 1;

    end

%     plot(GlobalDescTrain2);


ICV_LBP_Win = ICV_LBP_Window(TestImg,WindowDim);
ICV_NormalizedHisto = ICV_NormalizedHistogram(ICV_LBP_Win, WindowDim);


counter = 1;

    for z = 1:256:size(ICV_NormalizedHisto,1)*256 

             GlobalDescTest(z:z+255) = ICV_NormalizedHisto(counter,:);
             counter = counter + 1;

    end
% 
%     plot(GlobalDescTest);

    
    FaceDistance = 0;
    CarDistance = 0;
    
    for i = 1:size(GlobalDescTest)

        FaceDistance = FaceDistance + abs(GlobalDescTrain1(i) - GlobalDescTest(i) );
        CarDistance = CarDistance + abs(GlobalDescTrain2(i) - GlobalDescTest(i) );
    end

    
    if FaceDistance < CarDistance
       
        disp('It is a face');
    else
        
        disp('It is a car');
        
    end
    
    toc;



