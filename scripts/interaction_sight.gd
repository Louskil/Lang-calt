extends RayCast3D
class_name Interaction_rc

@onready var material
@onready var overlay

func _physics_process(delta: float) -> void:
	if self.is_colliding():
		var collider = self.get_collider()
		#material = collider.get_node("../../").outline_material
		#overlay = collider.get_node("../")
		var layer = collider.get_collision_layer()
		#overlay.material_overlay = material
		#print(layer)
		if layer == 4:
			material = collider.get_node("../../").outline_material
			overlay = collider.get_node("../")
			overlay.material_overlay = material
			
		# Xyeta pro predmet i teleport
		if Input.is_action_just_pressed("interact"):
			var character: Character = self.get_node("../../")
			if layer == 4:
				var object = collider.get_node("../../")
				character.inventory.add_item(object.item)
				object.queue_free()
			elif layer == 17:
				#print("test seat")
				var seat: Node3D = self.get_node("../../../sled")
				character.speed = 0
				character.velocity.x = 0
				character.velocity.y = 0
				character.velocity.z = 0
				if character.state == character.States.ON_SLED:
					character.state = character.States.ON_FOOT
				else:
					character.position = seat.position
					character.state = character.States.ON_SLED
				pass
			else:
				var marker: Marker3D = self.get_node("../../../TestTeleport") 
				character.position = marker.position
			
			
	else:
		if overlay != null:
			overlay.material_overlay = null
