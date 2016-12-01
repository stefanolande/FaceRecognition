clear;
input_dir = 'training/';
output_dir = 'training/processed/';
image_dims = [192, 168];

filenames = dir(fullfile(input_dir, '*.pgm'));
num_images = numel(filenames);

for n = 1:num_images
    filename = fullfile(input_dir, filenames(n).name);
    img = selfquotientimage(imread(filename), 7);
    imwrite(mat2gray(img), fullfile(output_dir, filenames(n).name));
end