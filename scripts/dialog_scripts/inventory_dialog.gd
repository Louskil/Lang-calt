class_name Invetory_Dialog
extends Control

@onready var ItemsContainer: GridContainer = %ItemsContainer
@export var ItemButton: PackedScene
@onready var Scene = $HSplitContainer/PanelContainer/SubViewportContainer/SubViewport/InvestigationScene

func open(inventory: _Inventory):
	show()
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	for child in ItemsContainer.get_children():
		child.queue_free()
	inventory._test_get_items()
	for item in inventory.get_items():
		var slot = ItemButton.instantiate()
		ItemsContainer.add_child(slot)
		slot.show_item(item)

func close():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Scene.hide_object()
	hide()
