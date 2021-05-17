function ICV_MotionDirection = ICV_GetMotionDirect(NewImg,OldImg,BlockSize,WindowSize)

% reads the video
OldImgSize = size(OldImg);
Direction = zeros(2,OldImgSize(1)*OldImgSize(2)/BlockSize*BlockSize);

ErrorCost = ones(2*WindowSize + 1, 2*WindowSize + 1) * 786439781264;



CurrentBlock = 1;

for a = 1:BlockSize:OldImgSize(1)+1
   for b = 1:BlockSize:OldImgSize(1)+1
       
 
       for c = -WindowSize:WindowSize
           for d = -WindowSize:WindowSize
               
               RowCoordinate = a + c;
               ColumnCoordinate = b + d;
               
               if(RowCoordinate < 1 || RowCoordinate + BlockSize - 1 > OldImgSize(1) || ColumnCoordinate + BlockSize - 1 > OldImgSize(2))
                   
                   continue
               end
               
               ErrorValue = 0;
               
               for e = 1:BlockSize
                   for f = 1:BlockSize
                       
                       ErrorValue = ErrorValue + abs((NewImg(e,f) - OldImg(e,f)));
                   end
               end
               ErrorCost(c + WindowSize + 1, d + WindowSize + 1)= ErrorValue/(BlockSize*BlockSize);
               
           end
       end
       
       [OldImg(1), OldImg(2)] = size(ErrorCost);
        MinimumError = 786439781264;
       
       for g = 1:OldImg(1)
           for h=1:OldImg(2)
               if ErrorCost(g,h)< MinimumError
                     MinimumError = ErrorCost(g,h);
                     dx = h;
                     dy = g;
                   
               end
           end
       end
       
       Direction(1,CurrentBlock) = abs(dy - WindowSize - 1);
       Direction(2,CurrentBlock) = abs(dx - WindowSize - 1);
       CurrentBlock = CurrentBlock + 1;
       
       ErrorCost = ones(2*WindowSize + 1, 2*WindowSize +1) * 786439781264;
   end
end
ICV_MotionDirection = Direction;
end