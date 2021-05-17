%% AUTHOR - BABATUNDE BAKARE
% 181075578


 
%% QUESTION 1A (i)
% ROTATION FUNCTION
% change the 'anglerot' value to alter the degree of rotation applied to
% the image
% please check the 'imread' file path before running the section

clear all, clc, close all; 

myname = imread('/Users/ethan/Documents/MATLAB/myname.png');

anglerot = -30;	%  ---------	---------	---------	---------	value to CHANGE

Rot = (ICV_rotation(myname, anglerot));


imshow(uint8(Rot));




%% QUESTION 1A (ii)
% SKEWING FUNCTION
% change the 'angle' value to alter the degree to which the image is skewed


clear all, clc, close all; 
myname = imread('/Users/ethan/Documents/MATLAB/myname.png');

angle = -10;    %  ---------	---------	---------	---------	value to CHANGE

Skew = (ICV_skewing(myname, angle));
imshow(uint8(Skew));


%% QUESTION 1B (i) & (ii)
% ROTATION & SKEWING FUNCTION

clear all, clc, close all; 
myname = imread('/Users/ethan/Documents/MATLAB/myname.png');

anglerot = 20;  %  ---------	---------	---------	---------	value to CHANGE
angle = 50;    %  ---------	---------	---------	---------	value to CHANGE
ICV_rotated = ICV_rotation(myname, anglerot);
ICV_skewed = ICV_skewing(myname, angle);


% to rotate and skew the image 
Rot_and_Skew = ICV_skewing(ICV_rotated, angle);

% to skew and rotate the image 
Skew_and_Rot = ICV_rotation(ICV_skewed, anglerot);

%prints the value of the rotated then skewed image
figure,imshow(uint8(Rot_and_Skew));


%prints the value of the skewed then rotated image
figure,imshow(uint8(Skew_and_Rot));




%% QUESTION 2A, B, C, D

% please check the 'imread' file path before running the section


clear all, clc, close all;

MyCar = imread('/Users/ethan/Documents/MATLAB/Dataset/Car-1.jpg');


kernel = ones(3); % creates a 3 by 3 array of digit value 'one' This our 3x3 filter


kernel1 = ones(5); % creates a 5 by 5 array of digit value 'one' This our 5x5 filter


kernel3 = ones(7); % creates a 7 by 7 array of digit value 'one' This our 7x7 filter


kernelA = [1,2,1;2,4,2;1,2,1]; % creates a 3 by 3 array of the digit values put in the array below


kernelA5X5 =  [  1     4     7     4     1;
                 4    18    30    18     4;
                 7    30    49    30     7;
                 4    18    30    18     4;
                 1     4     7     4     1];


kernelA7X7 = [ 1     1     2     2     2     1     1;
               1     3    14    22    14     3     1;
               2    14    59    97    59    14     2;
               2    22    97   160    97    22     2;
               2    14    59    97    59    14     2;
               1     3    14    22    14     3     1;
               1     1     2     2     2     1     1];

           
           
 kernelB5X5 = [0 0 1 0 0;
               0 0 1 0 0;
               1 1 -8 1 1;
               0 0 1 0 0;
               0 0 1 0 0];

           
           
 kernelB7X7 = [0 0 0 1 0 0 0;
               0 0 0 1 0 0 0;
               0 0 0 1 0 0 0;
               1 1 1 -12 1 1 1;
               0 0 0 1 0 0 0;
               0 0 0 1 0 0 0;
               0 0 0 1 0 0 0];

% creates a 3 by 3 array of the digit values put in the array below
kernelB = [0,1,0;1,-4,1;0,1,0];

% passing the filter over the 
ICV_convoluted = ICV_Convolution(MyCar,kernelB5X5); % ---------	---------	---------	---------	VALUE TO CHANGE


MyCarGrey2 = ICV_Convolution(ICV_convoluted,kernelA5X5); % ---------	---------	---------	---------	VALUE TO CHANGE



figure,imshow(uint8(ICV_convoluted));


figure,imshow(uint8(MyCarGrey2));




%% QUESTION 3A
% Histogram visualization
% please check the 'imread' file path before running the section

clear all, clc, close all;

HistVid_A = VideoReader('/Users/ethan/Documents/MATLAB/Dataset/DatasetB.avi');

VidFrame_A = read(HistVid_A);

i = 0:255;

% loop iterativelly through the each frame of the video
for j = 1:HistVid_A.NumFrames
    ICV_history = ICV_histogram_func_3a(VidFrame_A(:,:,:,j));
    imshow(VidFrame_A(:,:,:,j));
    title(['frame: ' num2str(j)]);
    stem(i,ICV_history(1,:),'color','r','marker','x','linestyle','-');
    hold on
    
    stem(i,ICV_history(2,:),'color','g','marker','x','linestyle','-');
    stem(i,ICV_history(3,:),'color','b','marker','x','linestyle','-');
    
    hold off
    title(['frame: ' num2str(j)]);
    pause(2/HistVid_A.FrameRate); %pauses the code output result for 2 seconds per frame


end

%% QUESTION 3B
% Histogram intersection

clear all, clc, close all;

HistVid_A = VideoReader('/Users/ethan/Documents/MATLAB/Dataset/DatasetB.avi');

VidFrame_A = read(HistVid_A);% reads frames the video

% loop iterativelly through the each frame of the video
for j = 1:HistVid_A.NumFrames - 1 
    h1 = ICV_histogram_func_3a(VidFrame_A(:,:,:,j));
    h2 = ICV_histogram_func_3a(VidFrame_A(:,:,:,j+1));
    intersection = ICV_histogram_func_3b(h1,h2);
   
    
    bar(0,intersection(1),'facecolor','r');
    hold on % retains plots in the current axes so that new plots added
    
    bar(1,intersection(2),'facecolor','g');
    bar(2,intersection(3),'facecolor','b');
    
    hold off % sets the hold state to off
    title(['frame: ' num2str(j)]);
    pause(1.5); %pauses the code output result for 1.5 seconds per frame
end
