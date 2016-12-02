clear;
input_dir = 'training/processed';
image_dims = [192, 168];

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

% display the eigenvalues
% normalised_evalues = evalues / sum(evalues);
% figure, plot(cumsum(normalised_evalues));
% xlabel('No. of eigenvectors'), ylabel('Variance accounted for');
% ylim([0 1]), grid on;

%genera la curva roc
input_dir = 'test/processed';
test_filenames = dir(fullfile(input_dir, '*.pgm'));
num_testimages = numel(test_filenames);

ROCv = zeros(num_testimages,2);

for n = 1:num_testimages   
    % calculate the similarity of the input to each training image
    filename = fullfile(input_dir, test_filenames(n).name);
    input_image = double(imread(filename));
    feature_vec = evectors' * (input_image(:) - mean_face);
    similarity_score = arrayfun(@(n) 1 / (1 + norm(features(:,n) - feature_vec)), 1:num_images);

    % find the image with the highest similarity
    [match_score, match_ix] = max(similarity_score);

    found_name = filenames(match_ix).name;
    true_name = test_filenames(n).name;

    true_class = strcmp(true_name(1:7), found_name(1:7));
    
    ROCv(n,1) = match_score;
    ROCv(n,2) = true_class;
    
end

roc(ROCv);
