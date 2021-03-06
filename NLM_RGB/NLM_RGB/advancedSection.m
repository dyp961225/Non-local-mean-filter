%% Some parameters to set - make sure that your code works at image borders!
patchSize = 3;
sigma = [20, 5, 10]; % standard deviation (different for each image!)
h = 0.55; %decay parameter
windowSize = 9;

%TODO - Read an image (note that we provide you with smaller ones for
%debug in the subfolder 'debug' int the 'image' folder);
%Also unless you are feeling adventurous, stick with non-colour
%images for now.
%NOTE: for each image, please also read its CORRESPONDING 'clean' or
%reference image. We will need this later to do some analysis
%NOTE2: the noise level is different for each image (it is 20, 10, and 5 as
%indicated in the image file names)

%REPLACE THIS
%imageNoisy = imread('alleyNoisy_sigma20.png');   %3,7:28.75
%imageNoisy = imread('townNoisy_sigma5.png');     %3,9:36.18 
imageNoisy = imread('treesNoisy_sigma10.png');    %3,5:28.80 

%imageReference = imread('alleyReference.png');
%imageReference = imread('townReference.png');
 imageReference = imread('treesReference.png');

tic;
%TODO - Implement the non-local means functions
filtered = nonLocalMeans(imageNoisy, sigma(3), h, patchSize, windowSize);
toc

%% Let's show your results!

%Show the denoised image
figure('name', 'NL-Means Denoised Image');
subplot(1,2,1),imshow(imageNoisy),title('Noisy image');
subplot(1,2,2),imshow(filtered), title('Denoisy image');

%Show difference image
diff_image = abs(double(imageNoisy) - double(filtered));
figure('name', 'Difference Image');
imshow(diff_image ./ max(max((diff_image))));

%Print some statistics ((Peak) Signal-To-Noise Ratio)
disp('For Noisy Input');
[peakSNR, SNR] = psnr(imageNoisy, imageReference);
disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);

disp('For Denoised Result');
[peakSNR, SNR] = psnr(filtered, imageReference);
disp(['SNR: ', num2str(SNR, 10), '; PSNR: ', num2str(peakSNR, 10)]);

%Feel free (if you like only :)) to use some other metrics (Root
%Mean-Square Error (RMSE), Structural Similarity Index (SSI) etc.)