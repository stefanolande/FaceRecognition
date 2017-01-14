clear;

addpath consegna/libs;

input_dir = 'dataset2/test/';
output_dir = 'dataset2/test/processed/';
image_dims = [192, 168];

filenames = dir(fullfile(input_dir, '*.pgm'));
num_images = numel(filenames);

for n = 1:num_images
    fprintf('%d/%d \n', n, num_images);
    filename = fullfile(input_dir, filenames(n).name);
    img = DCT_normalization(imread(filename));
    imwrite(mat2gray(img), fullfile(output_dir, filenames(n).name));
end