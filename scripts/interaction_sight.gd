extends RayCast3D
class_name Interaction_SightRayCast

@onready var material
@onready var overlay

func _physics_process(delta: float) -> void:
	if self.is_colliding():
		var collider = self.get_collider()
		material = collider.get_node("../../").outline_material
		overlay = collider.get_node("../")
		overlay.material_overlay = material
		
		if Input.is_action_just_pressed("interact"):
			var item: _Item = collider.get_node("../../").item
			print(item.Name)
	
	else:
		if overlay != null:
			overlay.material_overlay = null
