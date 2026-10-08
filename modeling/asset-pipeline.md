# WISE² 3D Asset Pipeline

## Stage 1: Concept
- Sketch 2D designs
- Create mood boards
- Define polygon budget
- Plan material/texture strategy

## Stage 2: Modeling
- Block out proportions (high-level geometry)
- Refine details iteratively
- Create UV maps
- Test topology

## Stage 3: Texturing
- Paint diffuse/albedo maps
- Create normal maps (baking or painting)
- Add metallic/roughness maps
- Bake AO (Ambient Occlusion)

## Stage 4: Export Pipeline

```
Model (Blender)
    ↓
[Choose Target]
    ├─→ Web (glTF 2.0)      → Draco compressed .glb
    ├─→ Games (FBX)          → With armature & animations
    ├─→ Print (STL)          → Manifold check & scale
    └─→ AR (USDZ)            → iOS compatible
```

## Stage 5: Optimization

### For Web
- Target: < 5MB total (model + textures)
- Decimate to 50-70% of original
- Compress textures (WebP preferred)
- Use Draco compression for glTF

### For Games
- Target: < 500K triangles
- Keep UVs efficient
- Bake lighting if static
- Use material atlasing

### For Print
- Manifold validation
- Check wall thickness (>= 1mm)
- Scale to correct units
- Generate supports if needed

## Quality Checkpoints

- [ ] Model loads in WISE² Web Viewer
- [ ] Normal maps render correctly
- [ ] Texture resolution appropriate
- [ ] File size within budget
- [ ] No floating geometry
- [ ] Materials preview correctly

## Tools

| Task | Tool | Notes |
|------|------|-------|
| Modeling | Blender | Free, open-source |
| Sculpting | Sculpt-mode (Blender) | Or ZBrush for detail |
| Texturing | Substance Painter | Industry standard |
| Baking | Blender / Marmoset | GPU-accelerated |
| Compression | Meshlab / Draco | Reduce file size |

## File Organization

```
assets/models/
├── character/
│   ├── character.blend
│   ├── exports/
│   │   ├── character.glb
│   │   └── character.fbx
│   └── textures/
│       ├── character_diffuse.png
│       ├── character_normal.png
│       └── character_roughness.png
└── environment/
    ├── env.blend
    └── exports/
```

