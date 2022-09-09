# CelluloseSRFM
A data repository for manuscript "Direct imaging of the alternating disordered and crystalline structure of cellulose fibrils via super-resolution fluorescence microscopy" 

Acquiring fibril intensity profiles:
1.	Open ImageJ
2.	Load the "Save_ROI_Processed.ijm" macro
3.	Open an SRFM image of cellulose
4.	Using the segmented line tool, manually trace the dimmest cellulose fibrils (representing thin ribbons) with a line width of 40 and "Spline Fit" turned on. Hit "t" to add each trace to the ROI manager.
5.	Once all the fibrils have been traced, run the macro to automatically acquire and save fibril intensity profiles and ROIs
6.	Close the image and open the next one
7.	Repeat for all SRFM cellulose images

Analyzing intensity profiles:
1.	Open MATLAB
2.	Load “get_spacings_final.m” and “Peak_Analysis_final.m”
3.	Change pixelsize variable value to match that of your SRFM image
4.	Run “Peak_Analysis_final.m”
5.	Select the directory containing all the cellulose profiles
6.	Obtain dark and bright region length measurements from “sp” and “wi”, respectively 
