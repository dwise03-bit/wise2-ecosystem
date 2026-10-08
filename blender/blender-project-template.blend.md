# WISE² Blender Project Template

## Project Structure

```
my-model/
├── blender/
│   └── model.blend          # Main Blender file
├── exports/
│   ├── model.glb            # Web (Three.js/Babylon.js)
│   ├── model.fbx            # Game engines
│   ├── model.stl            # 3D printing
│   └── model.usdz           # AR/iOS
├── textures/
│   ├── diffuse.png
│   ├── normal.png
│   ├── metallic.png
│   └── roughness.png
├── renders/
│   ├── preview.png
│   └── turntable.mp4
└── docs/
    ├── model-specs.md
    └── export-settings.txt
```

## Blender Best Practices

### Modeling
- Keep topology clean (avoid N-gons where possible)
- Use modifiers non-destructively
- Name objects & materials clearly
- Delete unused data (Mesh > Clean Up)

### Materials
- Use PBR workflow (Principled BSDF)
- Bake textures for performance
- Keep texture resolution reasonable (512-2048)
- Use 16-bit PNGs for quality

### Optimization
1. Decimate models for web (50-70% reduction)
2. Bake lighting for static scenes
3. Use normal maps instead of geometry
4. Apply all transforms before export

### Export Settings

**For Web (glTF 2.0):**
```
- Format: GLB (Draco compression)
- Apply Modifiers: ON
- Include Normals: ON
- Include Tangents: ON
- Compression: Draco
```

**For Games (FBX):**
```
- Use Mesh Modifiers: ON
- Smoothing Groups: ON
- Apply Modifiers: ON
- Triangulate Faces: ON
```

**For 3D Printing (STL):**
```
- Apply Modifiers: ON
- Selection Only: OFF
- Scale (mm to chosen unit): 1000
- Check for manifold/errors first
```

## Workflow

1. **Model in Blender**
   - Sculpt geometry
   - Add materials & textures
   - Test with WISE² addon preview

2. **Optimize**
   - Use Decimate modifier
   - Bake textures
   - Check poly count

3. **Export**
   - Save .blend file
   - Export each format needed
   - Save preview renders

4. **Deploy**
   - Web: Upload .glb to asset server
   - Games: Import .fbx to engine
   - Print: Load .stl in slicer software
   - AR: Use .usdz for iOS

## WISE² Color Palette

For consistency with WISE² branding:
- Primary Green: RGB(0, 255, 136) / #00ff88
- Dark Background: RGB(10, 14, 26) / #0a0e1a
- Light Text: RGB(224, 230, 240) / #e0e6f0
- Border: RGB(30, 36, 50) / #1e2432

Use these in material base colors and lighting.

## Performance Targets

| Target | Web | Games | Print |
|--------|-----|-------|-------|
| Poly Count | <100K | <500K | N/A |
| Texture Res | 1024 | 2048 | N/A |
| File Size | <5MB | <20MB | <50MB |
| Draw Calls | <20 | <100 | N/A |

