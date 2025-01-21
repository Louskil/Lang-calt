extends CanvasLayer

@onready var player = %player
@onready var inventory_dialog: Invetory_Dialog = %InventoryDialog

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Inventory") and !inventory_dialog.visible:
		inventory_dialog.open(player.inventory)
	elif event.is_action_pressed("Inventory") and inventory_dialog.visible:
		inventory_dialog.close()
