function ICV_transformation(image, angle)

%% ONE SECTION

myname = imread('/Users/ethan/Documents/MATLAB/myname.png');
myna = imread('/Users/ethan/Documents/MATLAB/Dataset/Car-2.jpg');
imshow(myname)
imshow(myna)
%% new
myname = imread('/Users/ethan/Documents/MATLAB/myname.png');

 
%% IMAGE ROTATION
 
% stores array matrice in 'myname' within a and b 
MaxSize = size(myname);

% RowAcolB = uint8(zeros(MaxSize));



B = -30;

MaxValue = MaxSize(1);


if MaxValue < MaxSize(2);
    MaxValue = MaxSize(2);
end

minX = 0;
minY = 0;

for i = 1:MaxSize(1);
    for j = 1:MaxSize(2);
       
        NewXval = round(j*cosd(B) - i*sind(B));
        NewYval = round(j*sind(B) + i*cosd(B));
        if minX > NewXval;
            minX = NewXval;
        end
        
        if minY > NewYval;
            minY = NewYval;
        end
        
    end
end

for i = 1:MaxSize(1);
    for j = 1:MaxSize(2);
       
        NewXval = round(j*cosd(B) - i*sind(B));
        NewYval = round(j*sind(B) + i*cosd(B));

        RowAcolB(NewYval+round(minY*-1)+1, NewXval+floor(minX*-1)+1, :) = myname(i, j, :);
    end
end


[p,q,n]=size(RowAcolB);


FilteredRowAcolB = zeros(p,q,n);


for y=2:p-1
    
    for z=2:q-1
        
        filteredimg=[RowAcolB(y-1,z-1,:),RowAcolB(y-1,z,:),RowAcolB(y-1,z+1,:),RowAcolB(y,z-1,:),...
        RowAcolB(y,z,:),RowAcolB(y,z+1,:),RowAcolB(y+1,z-1,:),RowAcolB(y+1,z,:),RowAcolB(y+1,z+1,:)];
       
        FilteredRowAcolB(y,z,:)=median(filteredimg);

        
    end
end



imshow(uint8(FilteredRowAcolB));


%% IMAGE SKEWING
 
% stores array matrice in 'myname' within a and b 
MaxSize = size(myname);
RowAcolBskew = zeros(MaxSize(1),MaxSize(2),3,'uint8');



A = -10;


minA = 0;
minB = 0;

for i = 1:MaxSize(1);
    for j = 1:MaxSize(2);
       
        NewXval = round(j+ (1/tand(A))*i);
        NewYval = round(i);

        if minA > NewXval;
            minA = NewXval;
        end
        
        if minB > NewYval;
            minB = NewYval;
        end
        
    end
end


for i = 1:MaxSize(1);
    for j = 1:MaxSize(2);
       
        NewXval = round(j+ (1/tand(A))*i);
        NewYval = round(i);

        RowAcolBskew(NewYval+round(minB*-1)+1, NewXval+floor(minA*-1)+1, :) = myname(i, j, :);
    end
end

imshow(uint8(RowAcolBskew));



end