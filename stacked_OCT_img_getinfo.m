% This code calculates average intensity of stacked OCT image inside a
% 400um box
% Instructions: Set current folder to folder containing the ".fig" file
    % Change the name of the file to your ".fig" file
    % Click Run
    % Simply drag the box to the Lesion ROI.
    % Press "Enter" or double click the box
% Author: Yihua Zhu

h = hgload('13.fig');
axesObjs = get(h, 'Children');       % get the axes object from the handle
imageObj = get(axesObjs, 'Children')  % get the image object from the axes object
img = imageObj.CData;

%Draw ROI in imfreehand and get ROI info
fontSize = 16;
imshow(img, []);
axis on;
title('Original Image', 'FontSize', fontSize);
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.

% Ask user to draw Square.
message = sprintf('Drag the box to the Lesion ROI.\nDo not change the size of the box');
uiwait(msgbox(message));
h = imrect(gca,[10 10 17 17]);
position = wait(h);

% Create a binary image ("mask") from the ROI object.
binaryImage = h.createMask();

% Display image
subplot(2, 1, 1);
imshow(img, []);
axis on;
drawnow;
title('Original Image', 'FontSize', fontSize);

% Label the binary image to transillumination image and compute the centroid and center of mass.
labeledImage = bwlabel(binaryImage);
measurements_trans = regionprops(binaryImage, img, ...
    'Area', 'Centroid', 'WeightedCentroid', 'Perimeter');
area_trans = measurements_trans.Area
centroid_trans = measurements_trans.Centroid
centerOfMass_trans = measurements_trans.WeightedCentroid
perimeter_trans = measurements_trans.Perimeter

% Calculate the area, in pixels, that they drew.
numberOfPixels1 = sum(binaryImage(:))
% Another way to calculate it that takes fractional pixels into account.
numberOfPixels2 = bwarea(binaryImage)

% Get coordinates of the boundary of the freehand drawn region.
structBoundaries = bwboundaries(binaryImage);
xy=structBoundaries{1}; % Get n by 2 array of x,y coordinates.
x = xy(:, 2); % Columns.
y = xy(:, 1); % Rows.
subplot(2, 1, 1); % Plot over original image.
hold on; 
plot(x, y, 'LineWidth', 2);
drawnow; % Force it to draw immediately.


% Mask the images outside the mask, and display it.
% Will keep only the part of the image that's inside the mask, zero outside mask.
blackMaskedImage = img;
blackMaskedImage(~binaryImage) = 0;

% Calculate the means
meanGL = mean(blackMaskedImage(binaryImage));
sdGL = std(double(blackMaskedImage(binaryImage)));

% Report results.
message = sprintf('ROI mean = %.3f\nROI Standard Deviation = %.3f\nNumber of pixels = %d', meanGL, sdGL, numberOfPixels1);
msgbox(message);