# Motion Estimation and Local Binary Pattern(LBP) Classification


### Overview:
Implementing a Local Binary Pattern (LBP) Classifier on images and Motion Estimation on moving vehicles video. Both tasks done from scratch using MATLAB. The file titled **"code"** contains the code and instructions to run it




## LBP Classification

LBP (Local Binary Pattern) is a visual descriptor which implements a texture operation to label the pixels of an image.

The LBP Global Descriptors are made from a concatenation of texture histogram windows of both the face and the car image. It’s used to represent each image from the train set as well as test set in this case (Train car image and Train face image) train images and (Test car image) Test image. The  LBP Classifier then compare the main histograms (global descriptors) of the train images(car and face) respectively with the input test image. This is done by using the Euclidean distance method where distance, which is the absolute difference between the train global descriptor and the test global descriptor calculated and used as a confidence measurement. 

The lower the confidence measurement between a respective train and test global descriptor the higher the similarity.

The prior test image of the test histogram, is classified under the train image with which it has the smaller distance (and effectively largest similarity).




<img src="https://github.com/ethanbakare/Motion-Estimation-and-LBP-Classification/blob/main/images/LBP_classifier.png" width = "500"/>



## Motion Estimation

The image below demonstrates the use of the block matching algorithm. The “left” image being the previous frame and the “right” image the current frame. By using blocking matching the motion vectors of moving objects from previous to current frame is calculated and such the direction of motion superimposed on the current image.



### Prediction of next video frame 

Utilising the calculated motion vectors obtained via the block matching algorithm. The subsequent frame in the video can be predicted throughout the motion vectors. As illustrated below we can see the actual frame versus predicted frame.

