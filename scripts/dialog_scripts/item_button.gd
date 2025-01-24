extends Button

@onready var Icon = %ItemIcon
@onready var ItemName = %ItemName
@onready var ItemQuantity = %ItemQuantity
@onready var ItemDialog: Invetory_Dialog = get_node("../../../../../")
@onready var Scene = get_node("../../../../PanelContainer/VBoxContainer/SubViewportContainer/SubViewport/InvestigationScene")
@onready var ItemDescription: Label = get_node("../../../../PanelContainer/VBoxContainer/DescriptionBox")
@onready var _item: Item

func show_item(item: Item):
	_item = item
	Icon.texture = item.Icon
	ItemName.text = item.Name
	ItemQuantity.text = "x" + str(item.Quantity)
	
	pass


func _on_pressed() -> void:
	Scene.show_object(_item)
	ItemDescription.text = _item.Description
