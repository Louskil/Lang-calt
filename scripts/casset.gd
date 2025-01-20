extends Node3D

@export var mesh: MeshInstance3D
@export var outline_material: Material
@export var item: _Item

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#on_hit_by_raycast()
	#pass
#
#func on_hit_by_raycast():
	#if sight.is_colliding():
		#mesh.material_overlay = outline_material
	#else:
		#mesh.material_overlay = null
