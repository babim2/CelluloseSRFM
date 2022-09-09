//Trace fibrils with segmented line tool using width of 40 and spline fit
//Hit "t" each time a fibril is traced to add ROI to ROI manager
//Execute this macro once all fibrils have been traced and are ready to save

imagename = getTitle();
path = getInfo("image.directory");
path_profiles = path + "\\Profiles";
//Make new folder for ROIs
File.makeDirectory(path_profiles);
count=roiManager("count");

//Plot and save all ROI profiles
for (i=0;i<count;i++){
	selectWindow(imagename);
	roiManager("select",i);
	roiName = "ROI_" + i;
	profileName = roiName + "_Profile";
	roiManager("Rename", roiName);
	
	//save ROI co-ordinates in case raw SMLM data analysis is needed
	run("Line to Area");
	getSelectionCoordinates(x_coord, y_coord);
	for(k=0; k<x_coord.length; k++){
		setResult("x",k,x_coord[k]);
		setResult("y",k,y_coord[k]);
	}
	updateResults();
	selectWindow("Results");
	saveAs("text", path_profiles + "\\" + roiName + "_BoundingCoords.txt");
	run("Close");
	selectWindow(imagename);
	roiManager("select",i);
	
	//Plot and save fibril profile
	run("Plot Profile");
	Plot.showValues();
	selectWindow("Results");
	saveAs("text", path_profiles + "\\" + profileName + ".txt");
	selectWindow("Results");
	run("Close");
	x =  split(imagename,".");
	selectWindow("Plot of " + x[0]);
	run("Close");
}

//Save ROIs
roiManager("save", path_profiles + "\\ROIs.zip");
roiManager("reset");