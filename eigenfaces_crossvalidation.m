clear;
input_dir = '/home/stefano/FaceRecognition/yale_processed/';
image_dims = [192, 168];

filenames = dir(fullfile(input_dir, '*.pgm'));
num_images = numel(filenames);

filename = fullfile(input_dir, filenames(1).name);
img = imread(filename);
dim = size(img(:));

images = zeros(dim(1), num_images);
subjects = char(zeros(num_images, 2));

for n = 1:num_images
    filename = fullfile(input_dir, filenames(n).name);
    img = imread(filename);
    images(:, n) = img(:);
    subjects(n, :) = filenames(n).name(6:7);
end

CVO = cvpartition(subjects,'k',10);

AUCSum = 0;

for i = 1:CVO.NumTestSets
    
    fprintf('fold %d of %d\n', i, CVO.NumTestSets);
    
    trIdx = CVO.training(i);
    teIdx = CVO.test(i);
    
    trainingImages =  images(:, trIdx);
    testImages =  images(:, teIdx);
    trainingSubjects = subjects(trIdx, :);
    testSubjects = subjects(teIdx, :);
    
    num_images = size(trainingImages,2);
    
    %addestra eigenfaces    
    mean_face = mean(trainingImages, 2);
    shifted_images = trainingImages - repmat(mean_face, 1, num_images);
    fprintf('training steps 1&2 done\n');

    [evectors, score, evalues] = pca(trainingImages');
    fprintf('training steps 3&4 done\n');

    num_eigenfaces = 20;
    evectors = evectors(:, 1:num_eigenfaces);
    fprintf('training step 5 done\n');

    features = evectors' * shifted_images;
    fprintf('training step 6 done\n');
    
    %calcola ROC e AUC
    ROCv = zeros(CVO.TestSize(i),2);
    
    for j = 1:CVO.TestSize
           
        input_image = double(testImages(j));
        feature_vec = evectors' * (input_image(:) - mean_face);
        similarity_score = arrayfun(@(n) 1 / (1 + norm(features(:,n) - feature_vec)), 1:num_images);

        [match_score, match_ix] = max(similarity_score);

        found_name = trainingSubjects(match_ix, :);
        true_name = testSubjects(j, :);

        true_class = strcmp(true_name, found_name);

        ROCv(j,1) = match_score;
        ROCv(j,2) = true_class;
    end
    
    rocOut = roc(ROCv,0, 0.05, 0);
    AUCSum = AUCSum + rocOut.AUC;
    fprintf('AUC: %f\n', rocOut.AUC);

end

avgAUC = AUCSum / CVO.NumTestSets;
fprintf('End!`n Average AUC: %f\n', avgAUC);

