%% Choose directory containing all intensity profiles
dirFolder = uigetdir();

% Set file extension of intensity profiles
profileExtension = '*Profile.txt';

%Indicate pixel size of SR image in microns
pixelsize = 0.0096;

appendFullPath = 1;
dir_profiles = getAllFiles (dirFolder, profileExtension, appendFullPath, 1E0);

for i=1:size(dir_profiles,1)
    delimiter = '\t';
    startRow = 2;
    formatSpec1 = '%f%f%f%[^\n\r]';

    fileID = fopen(dir_profiles{i},'r');
    dataArray1 = textscan(fileID, formatSpec1, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
    fclose(fileID);

%   parse intensity profile data into variables. Change column number
%   appropriately, depending on whether ImageJ saves row number
    x_all{i} = dataArray1{:, 2};
    y_all{i} = dataArray1{:, 3};
end

%% Choose peak finding parameters
MinPeakDistance = 0.04;
MinPeakWidth = 0.02;

%% Choose profile normalization
normalize_y = 1;

%% Determine spacing and FWHM lengths of all acquired profiles
for i=1:size(x_all,2)  
    [spacing{i}, pks{i}, locs{i}, w{i}, p{i}, p_normalized{i}, threshold(i)] = get_spacings_final...
    (y_all{i}, x_all{i}, MinPeakDistance, MinPeakWidth);
end

% aggregated spacing (dark region length) measurements
sp = [];
for i = 1:length(spacing)
    sp = [sp spacing{i}]; end 

% aggregated peak FWHM (bright region length) measurements
wi = [];
for i = 1:length(w)
    wi = [wi w{i}']; end 

% average spacing length per fibril
for i = 1:length(spacing)
sp_avg(i) = mean(spacing{i}); end

% average intensity per fibril. Can convert to localizations by dividing by
% 0.4
for i = 1:length(y_all)
y_avg(i) = mean(y_all{i}); end

% fibril length data
for i = 1:length(y_all)
fibLength(i) = max(x_all{i}); end

% aggregated intensity values
y_all2 = [];
for i = 1:length(y_all)
y_all2 = [y_all2 y_all{i}']; end

% aggregated peak prominences
p_all = [];
for i = 1:length(p)
p_all = [p_all p{i}']; end

% aggregated ratio of bright region and dark region intensities
p_normalized_all = [];
for i = 1:length(p_normalized)
p_normalized_all = [p_normalized_all p_normalized{i}']; end

% converting intensity to localizations
p_normalized_all_2 = p_normalized_all./0.4;