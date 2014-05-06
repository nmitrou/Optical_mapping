%% load tiff files and name them


% filenames of some tiff files I have
savename = '/Users/nickmitrou/Documents/SFU/PhD/Projects/Optical_map/Results/Video';
filename1 = '/Users/nickmitrou/Documents/SFU/PhD/Data/IFN-y/IF/13G22_CTL1_cx40_40x_600ms_1.tif';
filename2 = '/Users/nickmitrou/Documents/SFU/PhD/Data/IFN-y/IF/13G22_CTL1_cx40_40x_600ms_1_AF488.tif';
filename3 = '/Users/nickmitrou/Documents/SFU/PhD/Data/IFN-y/IF/13G22_CTL1_cx40_40x_600ms_1_DAPI.tif';
% command to read in the image files and rename them
im1 = imread(filename1,'Tiff');
im2 = imread(filename2,'Tiff');
im3 = imread(filename3,'Tiff');
%% Repack the individual images into one 3D matrix

im1m = squeeze(mean(im1,3)); % tiff files come as 3 separate channels, so take the average for each image
im2m = squeeze(mean(im2,3));
im3m = squeeze(mean(im3,3));

szx = size(im1,1);
szy = size(im1,2);

imset = zeros(szx,szy,3);


imset(:,:,1) = im1m;
imset(:,:,2) = im2m;
imset(:,:,3) = im3m;


%%
% find an isochronal line on each image. Isochronal has to be made up
writerobj = VideoWriter([savename '_IsoChronal.avi']);
open(writerobj);

testbox = zeros(50,50,50);
for j = 1:50
    testbox(1:j,:,j) = 3;
    imagesc(squeeze(testbox(:,:,j)))
    frame = getframe;
    writeVideo(writerobj,frame);
end
close(writerobj);
%% make video from tiff files
nFrames = size(imset,3);
writerobj = VideoWriter([savename '_TestVid.avi']);
open(writerobj);

for i=1:nFrames;
    image(imset(:,:,i));  
    frame = getframe;
    writeVideo(writerobj,frame);
end
close(writerobj);