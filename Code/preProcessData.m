function [imageMatrices, lightDirections, denoLight] = preProcessData(x, y, z)
[~,~,index] = resamplingData(x, y, z);
s = size(index, 1);
imageMatrices = zeros(237, 200, s); % image size need to be changed every time!!
lightDirections = zeros(s, 3);
for i = 1:s
   lightDirections(i, :) = [x(index(i)), y(index(i)), z(index(i))];
   %absolutePath of input data
   absolutePath = '/Input/data10/image';
   if index(i)<10
       path = strcat(absolutePath, '000', num2str(index(i)), '.bmp');
   elseif index(i)<100
       path = strcat(absolutePath, '00', num2str(index(i)), '.bmp');
   elseif index(i)<1000
       path = strcat(absolutePath, '0', num2str(index(i)), '.bmp');
   else
       path = strcat(absolutePath, num2str(index(i)), '.bmp');
   end
   img = imread(path);
   img = rgb2gray(img);
   imageMatrices(:, :, i) = double(img);
end

% find denominator image
percentile = 0.9;
intensitySum = sum(sum(imageMatrices,1),2);
[~,idx] = sort(intensitySum);
denominatorImage = imageMatrices(:,:,idx(floor(percentile*s)));
imshow(uint8(denominatorImage));

for i = 1:s
    % divide denominator image
    imageMatrices(:,:,i) = imageMatrices(:,:,i)./denominatorImage;
end
imageMatrices(:, :, idx(floor(percentile*s))) = [];
denoLight = lightDirections(idx(floor(percentile*s)), :);
lightDirections(idx(floor(percentile*s)), :) = [];
end