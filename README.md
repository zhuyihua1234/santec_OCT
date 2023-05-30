# santec_OCT
Data Conversion for Santec Swept-Source OCT systems

"PSOCT_Santec2Dragonfly_Conversion.m": Convert Santec PSOCT images into ".raw" format which is readable by ORS Dragonfly.

"CPOCT_3Dconversion_Distortion_Correction.m": Convert Santec CPOCT images into ".raw" format which is readable by ORS Dragonfly. This code also applies custom matrix transformation to correct spacial distortion in the y-axis.

"FindMedianIntensity_From_Dragonfly_Population_Profile.m": Automatically identify the median intensity from histogram saved by ORS Dragonfly. 

"OCT_Bscan_getinfo.m": Analysis of image saved by B-scan 2D mode of Santec OCT system.

"Stacked_OCT_img_getinfo.m": Calculate average intensity inside 500um boxed ROI for stacked OCT image
