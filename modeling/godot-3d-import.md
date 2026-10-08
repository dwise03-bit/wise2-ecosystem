# Godot 3D Model Import Guide

## Best Practices for Godot 4

### FBX Import Settings
```
Meshes:
  - Ensure Skeletal: OFF (unless rigged)
  - Root Type: Mesh
  - Root Name: (model name)
  - Meshes: ON
  - Animations: ON (if rigged)

Materials:
  - Import Materials: ON
  - Import Textures: ON
  - Reimport: Enabled
```

### Optimization in Godot
1. Use LOD (Level of Detail) for distant objects
2. Enable occlusion culling for large scenes
3. Use mesh deduplication
4. Bake static lighting

### Scene Setup
```gdscript
# Load glTF model
var model = load("res://models/character.glb")
var instance = model.instantiate()
add_child(instance)

# Set up physics (if needed)
var physics_body = CharacterBody3D.new()
physics_body.add_child(instance)
```

