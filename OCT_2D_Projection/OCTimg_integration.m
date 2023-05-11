%This program reconstructs 3D OCT images into a 2D integrated map (at vertical axis)
% Instructions:
    %1. In ORS Dragonfly: Crop the image by using the "create a box" function, from the
    %surface of the sample and offset it by 500um
    %2. Click "Derive New from current view"
    %3. Export the image into TIFF stacks
    %4. IMPORTANT!!!: Make sure the number of TIFF images matches the true vertical axis.
    %5. Run this program in the folder containing the TIFF stacks
    %6. The result integrated 2D map is saved in the same folder
%Author: Yihua Zhu

clear all;

%Create a base 2D matrix with zeroes by using the empty space in OCT scan
base_matrix = imread("img001.tiff");

%Stack up tiff images inside working directory into the 2D base matrix
  d=dir('*.tiff');
  for i=1:length(d)
      %Reads in .tiff file
      fname = d(i).name;
      step_matrix = imread(fname);
      base_matrix = step_matrix + base_matrix
  end

%Make images brighter for display and save the result
img_16 = base_matrix * 2^(4);
imshow(img_16);
imwrite(img_16,"integrated_2D_Map.tif");