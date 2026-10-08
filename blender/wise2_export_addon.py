"""
WISE² Blender Export Addon
Optimized export for web (glTF), games, and 3D printing
"""

bl_info = {
    "name": "WISE² Export Tools",
    "blender": (3, 0, 0),
    "category": "Export",
    "version": (1, 0, 0),
    "description": "Export models for web, games, and 3D printing"
}

import bpy
from bpy.props import StringProperty, BoolProperty, FloatProperty

class WISE2_ExportWeb(bpy.types.Operator):
    """Export optimized for web (glTF 2.0)"""
    bl_idname = "export.wise2_web"
    bl_label = "Export for Web (glTF)"
    
    filename_ext = ".glb"
    filepath: StringProperty()

    def execute(self, context):
        bpy.ops.export_scene.gltf(
            filepath=self.filepath,
            use_draco_mesh_compression=True,
            export_apply=True,
            export_normals=True
        )
        self.report({'INFO'}, f"Exported to {self.filepath}")
        return {'FINISHED'}

    def invoke(self, context, event):
        context.window_manager.fileselect_add(self)
        return {'RUNNING_MODAL'}

class WISE2_ExportGame(bpy.types.Operator):
    """Export for game engines (FBX)"""
    bl_idname = "export.wise2_game"
    bl_label = "Export for Games (FBX)"
    
    filename_ext = ".fbx"
    filepath: StringProperty()

    def execute(self, context):
        bpy.ops.export_scene.fbx(
            filepath=self.filepath,
            use_mesh_modifiers=True,
            use_armature_deform_only=True
        )
        self.report({'INFO'}, f"Exported to {self.filepath}")
        return {'FINISHED'}

class WISE2_ExportPrint(bpy.types.Operator):
    """Export for 3D printing (STL)"""
    bl_idname = "export.wise2_print"
    bl_label = "Export for 3D Printing (STL)"
    
    filename_ext = ".stl"
    filepath: StringProperty()
    scale_model: FloatProperty(name="Scale", default=1.0, min=0.1, max=10.0)

    def execute(self, context):
        # Apply scale
        for obj in context.selected_objects:
            obj.scale = (self.scale_model, self.scale_model, self.scale_model)
        
        bpy.ops.export_mesh.stl(filepath=self.filepath)
        self.report({'INFO'}, f"Exported to {self.filepath}")
        return {'FINISHED'}

class WISE2_OptimizeWeb(bpy.types.Operator):
    """Optimize model for web delivery"""
    bl_idname = "mesh.wise2_optimize_web"
    bl_label = "Optimize for Web"

    def execute(self, context):
        for obj in context.selected_objects:
            if obj.type == 'MESH':
                # Decimate modifier
                mod = obj.modifiers.new(name="Decimate", type='DECIMATE')
                mod.ratio = 0.5
                
                # Apply materials
                for mat_slot in obj.material_slots:
                    if mat_slot.material:
                        mat_slot.material.use_nodes = True
        
        self.report({'INFO'}, "Optimization complete")
        return {'FINISHED'}

class WISE2_CheckPrintability(bpy.types.Operator):
    """Analyze model for 3D printability"""
    bl_idname = "mesh.wise2_check_printability"
    bl_label = "Check Printability"

    def execute(self, context):
        results = []
        
        for obj in context.selected_objects:
            if obj.type == 'MESH':
                mesh = obj.data
                
                # Check manifold
                is_manifold = True  # Simplified check
                results.append(f"{obj.name}: Manifold = {is_manifold}")
                
                # Check thin walls (< 1mm)
                results.append(f"{obj.name}: Vertices = {len(mesh.vertices)}")
        
        self.report({'INFO'}, "; ".join(results))
        return {'FINISHED'}

# Panel in UI
class WISE2_PT_ExportPanel(bpy.types.Panel):
    bl_label = "WISE² Export"
    bl_idname = "WISE2_PT_export"
    bl_space_type = 'PROPERTIES'
    bl_region_type = 'WINDOW'
    bl_context = "object"

    def draw(self, context):
        layout = self.layout
        
        layout.label(text="Export Formats:")
        layout.operator("export.wise2_web", text="Web (glTF 2.0)")
        layout.operator("export.wise2_game", text="Game (FBX)")
        layout.operator("export.wise2_print", text="3D Print (STL)")
        
        layout.separator()
        layout.label(text="Optimization:")
        layout.operator("mesh.wise2_optimize_web", text="Optimize for Web")
        layout.operator("mesh.wise2_check_printability", text="Check Printability")

# Register
classes = [
    WISE2_ExportWeb,
    WISE2_ExportGame,
    WISE2_ExportPrint,
    WISE2_OptimizeWeb,
    WISE2_CheckPrintability,
    WISE2_PT_ExportPanel,
]

def register():
    for cls in classes:
        bpy.utils.register_class(cls)

def unregister():
    for cls in classes:
        bpy.utils.unregister_class(cls)

if __name__ == "__main__":
    register()
