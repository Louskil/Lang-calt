extends Camera3D

var zoom_speed = .2
var zoom_direction = Vector3(0,0,-1)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP:
		translate((zoom_direction * zoom_speed))
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		translate(zoom_direction * -zoom_speed)
