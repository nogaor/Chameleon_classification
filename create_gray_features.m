function feats = create_gray_features(images, model,params)

feats = extractC2forcell(model.filters,model.fSiz, params.c1SpaceSS,params.c1ScaleSS,model.c1OL,...
     model.cPatches,images,params.numPatchSizes,model.numSimpleFilters);    
