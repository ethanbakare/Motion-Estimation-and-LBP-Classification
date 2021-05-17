function ICV_LBP_Win = ICV_LBP_Window(MyFace,WindowDim)


% MyFace = imread('/Users/ethan/Documents/MATLAB/second 181075578/Dataset (2)/DatasetA/face-2.jpg');

MyFaceGrey = double(0.299 * MyFace(:,:,1) + 0.587 * MyFace(:,:,2) + 0.114 * MyFace(:,:,3));
MyFaceGrey = double(MyFaceGrey);
% figure,imshow(uint8(MyFaceGrey));
    
    
MyFaceGrey = double(MyFace);


[a,b,~] = size(MyFaceGrey);
p = a+2;
q = b+2;

MyFaceGreyPadded = uint8(zeros(p,q));
MyFaceGreyPadded(2:a+1,2:b+1) = MyFaceGrey(1:a,1:b);

binary = zeros(1,8);

ImgGrey = uint8(zeros(a,b));

for y=2:p-1
    
    for z=2:q-1
        
        CompImg=[MyFaceGreyPadded(y,z-1), MyFaceGreyPadded(y+1,z-1), MyFaceGreyPadded(y+1,z), MyFaceGreyPadded(y+1,z+1),...
        MyFaceGreyPadded(y,z+1),MyFaceGreyPadded(y-1,z+1),MyFaceGreyPadded(y-1,z), MyFaceGreyPadded(y-1,z-1)];
        
        for v=1:8
        
            if CompImg(v) > MyFaceGreyPadded(y,z)
              
               binary(v) = 1; 
            else
                
               binary(v) = 0;   
            end
            
        end
        
        bin_img = 0;
        
        for r = 7:-1:0
            
            bin_img = bin_img + binary(r+1)*(2^(r)); 
        end
        
        ImgGrey(y-1,z-1) = bin_img;
        
    end
    
end

% ICV_Bin = ImgGrey;
   
LBPimg = ImgGrey;

[ImgHeight,ImgWidth] = size(LBPimg);
% WindowDim = 128;
WindowNumber = (ImgHeight/WindowDim)^2;
LBP_window = zeros(WindowDim,WindowDim,WindowNumber);

count = 1;
for i = 1:WindowDim:ImgHeight
    
    for j = 1:WindowDim:ImgWidth
        
        LBP_window(:,:,count) = LBPimg(i:i+WindowDim-1,j:j+WindowDim-1);
        count = count+1;
    end
    
end

LBP_window = uint8(LBP_window);
ICV_LBP_Win = LBP_window;
% HistoGrey = 0;
% 
% HistoGrey = zeros(WindowNumber,256);
% NormHistoGrey  = zeros(WindowNumber,256);
% HistIndex = zeros(1,256);
% 
% for la = 1:WindowNumber
% 
%     for rowA = 1:size(LBP_window,1)    
%         for colB = 1:size(LBP_window,2) 
% 
%             i = uint16(LBP_window(rowA, colB, WindowNumber));
%             HistIndex(i + 1) = HistIndex(i + 1) + 1;   
%         end
%         
%         HistoGrey(la,:) = HistIndex(:);
%         NormHist = HistIndex/(WindowDim*WindowDim);
%         NormHistoGrey(la,:) = NormHist(:);
%     end
%     

    
    
%     
% %     figure(1);
%     subplot(1,3,1);
%     imshow(LBP_window(:,:,la));
%     
% %     figure(2);
%     subplot(1,3,2);
%     plot(0:255, HistIndex);
%     drawnow();
%     
%     subplot(1,3,3);
%     plot(0:255, NormHist);
%     drawnow();
%     pause(.5);
%     
% %     plot(0:255, NormHistoGrey);
%     
% end


% counter = 1;
% 
% for z = 1:256:size(NormHistoGrey,1)*256 
%         
%          GlobalDesc(z:z+255) = NormHistoGrey(counter,:);
%          counter = counter + 1;
%    
% end
% 
% plot(GlobalDesc);


% for xx = 1: size(NormHistoGrey,1)
%     
%     for zz = 1:256
% 
%              GlobalDescA(zz) = NormHistoGrey(xx,zz);
%         
% 
%     end
% end
% 
% plot(GlobalDescA);


% figure,imshow(uint8(HistIndex));



% imshow(uint8(ICV_LBP));

% end
end

    