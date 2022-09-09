function [spacing, pks, locs, w, p, p_normalized, MinPeakProminence] = get_spacings_final(y_profile, x,  MinPeakDistance, MinPeakWidth)

%declare output variables
spacing = [];
pks = [];
locs = [];
w = [];
p = [];

%smoothen intensity profile to remove noise
b=[1/2 1/2];
a = 1;
yy = filtfilt(b,a,y_profile); 

%find all local maxima
[~, ~, ~, p] = findpeaks(yy,x,...
    'MinPeakProminence', 0);

%set threshold based on median inensity of all local maxima
MinPeakProminence = 1*median(p);

% If using global thresholding method (e.g. for DTAF), set absolute
% intensity value determined from the mean + 3*stdev of dark population.
% MinPeakProminence = 0.0688; For DTAF, use 0.344

% Find peaks representative of bright regions
[pks, locs, w, p] = findpeaks(yy,x,...
    'MinPeakProminence', MinPeakProminence,...
    'MinPeakDistance', MinPeakDistance,...
    'MinPeakWidth', MinPeakWidth);

% Discard peaks with a prominence/bkg ratio below 1
bkg = pks-p;
ratio = p./bkg;
thresh = 1;
pks(ratio<thresh)=[];
locs(ratio<thresh)=[];
w(ratio<thresh)=[];
p(ratio<thresh)=[];

% Determine seprartion distance between adjacent bright regions from their
% FWHM

for k=1:(size(locs,1)-1)
    spacing(k) = locs(k+1)+w(k+1)/2 -(locs(k)-w(k)/2) - w(k)-w(k+1);
end

% Return this value to determine intensity ratio between bright and dark
% regions
p_normalized = p./MinPeakProminence;

end