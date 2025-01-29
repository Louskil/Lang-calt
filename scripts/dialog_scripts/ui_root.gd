extends CanvasLayer

@onready var player = %player
@onready var inventory_dialog: Invetory_Dialog = %InventoryDialog
@onready var map_dialog: Map_Dialog = %map_dialog

var is_visible: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Inventory") and !map_dialog.visible:
		if !inventory_dialog.visible:
			player.is_locked = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			is_visible = true
			inventory_dialog.open(player.inventory)
		else:
			player.is_locked = false
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			is_visible = false
			inventory_dialog.close()
	if event.is_action_pressed("Mao") and !inventory_dialog.visible:
		if !map_dialog.visible:
			player.is_locked = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			is_visible = true
			map_dialog.open()
		else:
			player.is_locked = false
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			is_visible = false
			map_dialog.close()
		
