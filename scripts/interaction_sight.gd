extends RayCast3D

@onready var material
@onready var overlay

func _physics_process(delta: float) -> void:
	if self.is_colliding():
		var collider = self.get_collider()
		material = collider.get_node("../../").outline_material
		overlay = collider.get_node("../")
		overlay.material_overlay = material
		
		if Input.is_action_just_pressed("interact"):
			collider.get_node("../../").queue_free()
	
	else:
		if overlay != null:
			overlay.material_overlay = null
