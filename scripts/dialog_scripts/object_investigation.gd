extends Node3D

var is_rotating: bool = false
var mouse_offset: Vector2

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Click"):
		is_rotating = true
		mouse_offset = get_tree().root.get_mouse_position()
	elif Input.is_action_just_released("Click"):
		is_rotating = false
		
	if is_rotating:
		mouse_offset = get_tree().root.get_mouse_position() - mouse_offset
		%RotatingObject.rotation_degrees += Vector3(mouse_offset.y, mouse_offset.x, 0 ) * .4
		mouse_offset = get_tree().root.get_mouse_position()

func hide_object():
	for i in %RotatingObject.get_children():
		i.queue_free()
	hide()

func show_object(item: _Item):
	show()
	if %RotatingObject.get_child_count() > 0:
		for i in %RotatingObject.get_children():
			i.queue_free()
	if item != null:
		var instance = item.Scene.instantiate()
		%RotatingObject.add_child(instance)
		instance.global_position = Vector3(0,0,1000)
		
