 function ICV_historyIntersect = ICV_histogram_func_3b(histogram1,histogram2)

 
 % intializes and assigns a value 0 to the various variable s
    totalRindex = 0;
    totalGindex = 0;
    totalBindex = 0;
    
    
% loops through the each value, incrementally iterating by 1
    for count_i = 1:256
        
        totalRindex = totalRindex + min(histogram1(1,count_i),histogram2(1,count_i));
        totalGindex = totalGindex + min(histogram1(2,count_i),histogram2(1,count_i));
        totalBindex = totalBindex + min(histogram1(3,count_i),histogram2(1,count_i));
        
        
    end
    

ICV_historyIntersect = [totalRindex,totalGindex,totalBindex];

 end
