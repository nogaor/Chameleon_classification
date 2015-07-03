addpath ./serre-lab-color_hmax-c2a60c1/
addpath ./liblinear-1.7/matlab/

% flags
CREATE_GRAYSCALE_MODEL = false;
CREATE_COLOR_MODEL = false;
CREATE_GRAYSCALE_FEATURES = false;
CREATE_COLOR_FEATURES = false;
RUN_CLASSIFICATION_ON_GRAYSCALE = false;
RUN_CLASSIFICATION_ON_COLOR = false;

% Load Images
if CREATE_GRAYSCALE_MODEL || CREATE_COLOR_MODEL || CREATE_GRAYSCALE_FEATURES || CREATE_COLOR_FEATURES
    load data/cfilenames.mat;
    numfiles = length(cfilenames);
    cI = cell(1, numfiles); 
    for i = 1:numfiles
        cI{i} = double(imread(char(cfilenames{i})))./255.0;
    end
end

% create model
if CREATE_GRAYSCALE_MODEL || CREATE_COLOR_MODEL
    params.patchSizes = [4 8 12 16];
    params.numPatchSizes = length(params.patchSizes);
    params.numPatchesPerSize = 250;
    params.rot       = [0 90];
    params.RF_siz    = 7:2:39;
    params.Div       = 4:-.05:3.2;
    params.numPhases = 1;
    params.numChannel = 8; %numbers of opponent color channels
    params.c1ScaleSS = 1:2:18;
    params.c1SpaceSS = 8:2:22;
end

grayscale_model_filename = 'model/gray_model.mat';
if CREATE_GRAYSCALE_MODEL 
    gray_model = initialize_gray(cI, params);
else
    disp('loading grayscale model')
    load(grayscale_model_filename);
end

color_model_filename = 'model/color_model.mat';
if CREATE_COLOR_MODEL 
    color_model = initialize_color(cI, params);
else
    disp('loading color model')
    load(color_model_filename);
end


if CREATE_GRAYSCALE_FEATURES
    gray.XX = create_gray_features(cI, gray_model);
else
    gray = load('features/gray.mat')
end

if CREATE_COLOR_FEATURES
    color.XX = create_color_features(cI, color_model);
else
    color = load('features/color.mat');
end

load data/y.mat

% classify by gray features
if RUN_CLASSIFICATION_ON_GRAYSCALE
    [gray_accuracy, gray_p_value] = classify_pairwise_loo(gray.XX, y);
else
    load('classification_results/gray_acc.mat')
end
% choose the classes in the paper
inds = [6, 10, 7, 12, 8, 1];
letters = {'A','B','C','D','E','F'};

print_accuracy_table(gray_accuracy(inds,inds), letters, 3);
print_accuracy_table(gray_p_value(inds,inds), letters, 5);

% classify by color features
if RUN_CLASSIFICATION_ON_COLOR
    [color_accuracy,color_p_value] = classify_pairwise_loo(color.XX, y);
else
    load('classification_results/color_acc.mat');
end
print_accuracy_table(color_accuracy(inds, inds), letters, 3);
print_accuracy_table(color_p_value(inds, inds), letters,5);

