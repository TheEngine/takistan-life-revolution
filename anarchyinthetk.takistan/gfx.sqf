GFX_ArmaViewDistance         = 2000;
GFX_ArmaTerrainGrids         = [25, 12.5, 6.25];
// GFX_ArmaTerrainGrids         = [50, 25, 12.5, 6.25];
GFX_ArmaTerrainGridsSel      = 1;
setViewDistance GFX_ArmaViewDistance;
setTerrainGrid (GFX_ArmaTerrainGrids select GFX_ArmaTerrainGridsSel);
