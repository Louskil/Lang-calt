extends PanelContainer
class_name Map_Dialog


@onready var camera: Camera3D = self.get_node("../../map_camera")
@onready var view_port:  SubViewport = %SubViewport
@onready var player: CSGSphere3D = self.get_node("../../player/player_marker")

func open():
	player.visible = true
	show()

func close():
	player.visible = false
	hide()
