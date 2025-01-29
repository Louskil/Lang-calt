class_name Invetory_Dialog
extends Control

@onready var ItemsContainer: GridContainer = %ItemsContainer
@export var ItemButton: PackedScene
@onready var Scene = $HSplitContainer/PanelContainer/VBoxContainer/SubViewportContainer/SubViewport/InvestigationScene
@onready var ItemDescription = %DescriptionBox
@onready var Player = %player
func open(inventory: Inventory):
	show()
	
	
	for child in ItemsContainer.get_children():
		child.queue_free()
	for item in Player.inventory.get_items():
		var slot = ItemButton.instantiate()
		ItemsContainer.add_child(slot)
		slot.show_item(item)

func close():

	Scene.hide_object()
	ItemDescription.text = ""
	hide()
