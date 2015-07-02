fucntion model = initialize_color(cI, params)

model.cPatches = extractRandC1SoPatches(cI, params.numPatchSizes,params.numPatchesPerSize, params.patchSizes,...
    params.numChannel,params.numPhases);
[model.fSiz,model.a,model.cfilters,model.c1OL,model.numOrients]  = ...
    init_color_gabor(params.rot, params.RF_siz, params.Div,params.numChannel,params.numPhases);
   
