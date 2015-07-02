function feats = create_color_features(images, model, params)
 
feats = extractC2Soforcell(model.cfilters,model.fSiz,params.c1SpaceSS,params.c1ScaleSS,model.c1OL,...
    model.cPatches,images,params.numPatchSizes,params.numChannel,params.numPhases,model.numOrients);
