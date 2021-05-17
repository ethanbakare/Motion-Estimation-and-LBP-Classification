function ICV_skewed = ICV_skewing(myname, angle)


% assigns a value consisting of the number of rows, columns and channels in 'myname' to variable MaxSize
MaxSize = size(myname);

% creates an array of 'zeros' from the first and second value of MaxSize
RowAcolBskew = zeros(MaxSize(1),MaxSize(2),3,'uint8');


% assigns the variable A to the input 'angle' of the function ICV_skewed
A = angle;

% intializes and assigns a value 0 to the variable minA
minA = 0;
% intializes and assigns a value 0 to the variable minB
minB = 0;


% loops through the each pixel location, incrementally iterating by 1
for i = 1:MaxSize(1) 

    for j = 1:MaxSize(2)
       
        NewXval = round(j+ (1/tand(A))*i);
        NewYval = round(i);
        %get min values of the X and Y coordinates
        if minA > NewXval
            minA = NewXval;
        end
        
        if minB > NewYval
            minB = NewYval;
        end
        
    end
end

%determines the new size for the rotated image
for i = 1:MaxSize(1)
    for j = 1:MaxSize(2)
       % changes the location of each pixel on the Y axis shifting its
       % values
        NewXval = round(j+ (1/tand(A))*i);
        NewYval = round(i);

        RowAcolBskew(NewYval+round(minB*-1)+1, NewXval+floor(minA*-1)+1, :) = myname(i, j, :);
    end
end
ICV_skewed = uint8(RowAcolBskew);
% imshow(uint8(RowAcolBskew));
