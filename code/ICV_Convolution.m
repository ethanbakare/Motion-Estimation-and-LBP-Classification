function ICV_convoluted = ICV_Convolution(MyCar, kernel)

% the if statement helps to avoid grey filtering and already grey twice
% which aids in the convolution proccess
if size(MyCar,3) == 3
    MyCarGrey = double(0.299 * MyCar(:,:,1) + 0.587 * MyCar(:,:,2) + 0.114 * MyCar(:,:,3));
    MyCarGrey = double(MyCarGrey);
    figure,imshow(uint8(MyCarGrey));
    
else
    
    MyCarGrey = double(MyCar);
end

% assigns a value consisting of the number of rows and columns from the function input value to  variable imgkernel
imgkernel = size(kernel);

% assigns a value consisting of the number of rows and columns in 'myname' to variable MaxSize
imgsize = size(MyCarGrey);

% intializes and assigns a value 0 to the variable KernelSum
KernelSum = 0;


for k = 1:imgkernel(1)
    for l = 1:imgkernel(2)

        KernelSum = KernelSum + kernel(k,l);
               
    end
end

if KernelSum == 0
        
        KernelSum = 1;
end

ICV_convoluted=zeros(MyCarGrey(1),MyCarGrey(2),'double');

MidKernel = round(imgkernel(1)/2);
BorderSkip = imgkernel(1) - MidKernel;

for i = MidKernel:imgsize(1)-BorderSkip
    for j = MidKernel:imgsize(2)-BorderSkip
        
        SumFilter = double(0);
        
        for k = 1:imgkernel(1)
            for l = 1:imgkernel(2)

                SumFilter = SumFilter + double(MyCarGrey(i+k-MidKernel,j+l-MidKernel) * double(kernel(k,l)));
%                 MyCarGrey(i+k-MidKernel,j+l-MidKernel)
%                 double(kernel(k,l))
            end

        end
%         if KernelSum==1  
%             if SumFilter<0
%                 SumFilter = 0;
%             elseif SumFilter>255
%                 SumFilter = 255;
%             end
%         end
        ICV_convoluted(i,j) = double(SumFilter/KernelSum);
%         out(i,j)
    end
end











end