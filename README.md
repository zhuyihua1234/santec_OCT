# santec_OCT
Data Conversion for Santec Swept-Source OCT systems

***  Protocol for converting and loading PS-OCT images:
***  1. Use "PSOCT_Santec2Dragonfly_Conversion.m": Convert Santec PSOCT images into ".tif" image stacks format which is readable by ORS Dragonfly.
***  2. Use the following dimensional data to load the converted image stacks into ORS Dragonfly
***   Image Spacing (uncorrected for refractive index in enamel): 22.2222 um, Y:3.558 um, Z: 20um, Invert X-Axis
***   Image Spacing (corrected for refractive index in enamel): X: 22.2222 um, Y: 5.6928 um, Z: 20 um, Invert X-Axis
***    The above conversion unit takes into account of image distortion and refractive index of enamel

*** Protocol for converting and loading CP-OCT images

***  1. Use "CPOCT_3Dconversion_Distortion_Correction.m": Convert Santec CPOCT images into ".raw" format which is readable by ORS Dragonfly. This code also applies custom matrix transformation to correct spacial distortion in the y-axis.
***  2. Use the following dimensional data to load the converted ".raw" image into ORS Dragonfly
***  Image Parameters:  248 X 257 X 1024 Pixels (X,Y,Z)
***  Image Spacing (uncorrected for refraction index in enamel):  X: 23.438 um, Y: 23.438 um, Z: 9.524 um
***  Image Spacing (corrected for refractive index in enamel): X: 23.438 um, Y: 23.438 um, Z: 15.2384 um


"FindMedianIntensity_From_Dragonfly_Population_Profile.m": Automatically identify the median intensity from histogram saved by ORS Dragonfly. 

"OCT_Bscan_getinfo.m": Analysis of image saved by B-scan 2D mode of Santec OCT system.

"Stacked_OCT_img_getinfo.m": Calculate average intensity inside 500um boxed ROI for stacked OCT image
