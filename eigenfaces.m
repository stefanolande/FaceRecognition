clear;
input_dir = 'training/processed/';
image_dims = [192, 168];

soglia = 0.001;

filenames = dir(fullfile(input_dir, '*.pgm'));
num_images = numel(filenames);

%leggi la prima immagine per ottenere le dimensioni
filename = fullfile(input_dir, filenames(1).name);
img = imread(filename);
dim = size(img(:));

images = zeros(dim(1), num_images);

for n = 1:num_images
    filename = fullfile(input_dir, filenames(n).name);
    img = imread(filename);
    images(:, n) = img(:);
end

% steps 1 and 2: find the mean image and the mean-shifted input images
mean_face = mean(images, 2);
shifted_images = images - repmat(mean_face, 1, num_images);
fprintf('step 1 2 done\n');
 
% steps 3 and 4: calculate the ordered eigenvectors and eigenvalues
[evectors, score, evalues] = pca(images');
fprintf('step 3 4 done\n');
 
% step 5: only retain the top 'num_eigenfaces' eigenvectors (i.e. the principal components)
num_eigenfaces = 20;
evectors = evectors(:, 1:num_eigenfaces);
fprintf('step 5 done\n');
 
% step 6: project the images into the subspace to generate the feature vectors
features = evectors' * shifted_images;
fprintf('step 6 done\n');

input_dir = 'test/processed/';

name = '';
while(strcmp(name, 'esci')==0)
    name = input('Inserisci il nome dell''immagine da riconoscere o esci: ', 's');
    if(strcmp(name , 'esci')==0)
        % calculate the similarity of the input to each training image
        filename = fullfile(input_dir, name);
        input_image = double(imread(filename));
        feature_vec = evectors' * (input_image(:) - mean_face);
        similarity_score = arrayfun(@(n) 1 / (1 + norm(features(:,n) - feature_vec)), 1:num_images);

        % find the image with the highest similarity
        [match_score, match_ix] = max(similarity_score);

        % display the result
        figure, imshow([mat2gray(input_image) mat2gray(reshape(images(:,match_ix), image_dims))]);
        if(match_score>soglia)
            title(sprintf('matches %s, score %f', filenames(match_ix).name, match_score));
            xlabel('Accepted');
        else
            title(sprintf('closest %s, score %f', filenames(match_ix).name, match_score));
            xlabel('Rejected');
        end

    end
end