function model = initialize_gray(cI, params)

model.cPatches = extractRandC1Patches(cI, params.numPatchSizes,params.numPatchesPerSize, params.patchSizes);
[model.fSiz,model.filters,model.c1OL,model.numSimpleFilters] = init_gabor(params.rot, params.RF_siz, params.Div);
