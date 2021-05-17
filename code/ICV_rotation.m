function ICV_rotated = ICV_rotation(myname, anglerot)


 
% stores array matrice in 'myname' within a and b 
MaxSize = size(myname);


B = anglerot;   % assigns the variable B to the input 'anglerot' of the function ICV_rotation



minX = 0;   % intializes and assigns a value 0 to the variable minX

minY = 0;   % intializes and assigns a value 0 to the variable minY

%for each pixel find the new location
for i = 1:MaxSize(1)
    for j = 1:MaxSize(2)
        % changes the location of each pixel on the X and Y axis
        NewXval = round(j*cosd(B) - i*sind(B));
        NewYval = round(j*sind(B) + i*cosd(B));
        
        %get min values of the X an Y coordinates
        if minX > NewXval
            minX = NewXval;
        end
        
        if minY > NewYval
            minY = NewYval;
        end
        
    end
end
%determines the new size for the rotated image
for i = 1:MaxSize(1)
    for j = 1:MaxSize(2)
       
        NewXval = round(j*cosd(B) - i*sind(B));
        NewYval = round(j*sind(B) + i*cosd(B));
        
        RowAcolB(NewYval+round(minY*-1)+1, NewXval+floor(minX*-1)+1, :) = myname(i, j, :);
    end
end

% assigns a value consisting of the number of rows, columns and channels in
% 'RowAcolB' to variable p,q, and n

[p,q,n]=size(RowAcolB);

% creates an array of 'zeros' from the value of p,q and n
FilteredRowAcolB = zeros(p,q,n);

% removes the holes in the image by finding the median filter
% looping through each pixel value and empoying neighbourhood pixels to
% repair the holes
for y=2:p-1
    
    for z=2:q-1
        
        filteredimg=[RowAcolB(y-1,z-1,:),RowAcolB(y-1,z,:),RowAcolB(y-1,z+1,:),RowAcolB(y,z-1,:),...
        RowAcolB(y,z,:),RowAcolB(y,z+1,:),RowAcolB(y+1,z-1,:),RowAcolB(y+1,z,:),RowAcolB(y+1,z+1,:)];
       
        FilteredRowAcolB(y,z,:)=median(filteredimg);

        
    end
end


ICV_rotated = uint8(FilteredRowAcolB);
% imshow(uint8(FilteredRowAcolB));

end