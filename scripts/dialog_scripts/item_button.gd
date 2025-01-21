extends Button

enum State{
	inventory, 
	invesigation
}

@onready var Icon = %ItemIcon
@onready var ItemName = %ItemName
@onready var ItemQuantity = %ItemQuantity
@onready var ItemDialog: Invetory_Dialog = get_node("../../../../../")
@onready var Scene = get_node("../../../../PanelContainer/SubViewportContainer/SubViewport/InvestigationScene/")
@onready var _item: _Item

func show_item(item: _Item):
	_item = item
	Icon.texture = item.Icon
	ItemName.text = item.Name
	ItemQuantity.text = "x" + str(item.Quantity)
	
	pass


func _on_pressed() -> void:
	Scene.show_object(_item)
