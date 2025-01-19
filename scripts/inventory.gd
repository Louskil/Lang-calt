extends Control

var gridContainer : GridContainer
var items : Array
var capacity := 20
var hoveredButton
var grabbedButton
var lastClickedMousePos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gridContainer = $ScrollContainer/GridContainer
	populateButtons()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Двигаем предмет по инвентарю
func _process(delta: float) -> void:
	$MouseArea.position = get_tree().root.get_mouse_position()
	if hoveredButton != null:
		if Input.is_action_just_pressed("Click"):
			grabbedButton = hoveredButton
			lastClickedMousePos = get_tree().root.get_mouse_position()
		
		if lastClickedMousePos.distance_to(get_tree().root.get_mouse_position()) > 1:
			if Input.is_action_pressed("Click"):
				$MouseArea/InventoryButton.show()
				$MouseArea/InventoryButton.UpdateItem(grabbedButton.currentItem, 0)
			if Input.is_action_just_released("Click"):
				if(grabbedButton != null && hoveredButton != null):
					SwapButtons(grabbedButton, hoveredButton)
				$MouseArea/InventoryButton.hide()
				
	if Input.is_action_just_released("Click") && $MouseArea/InventoryButton.visible:
		$MouseArea/InventoryButton.hide()
		grabbedButton = null
	pass

# В итоге передвижения предмета в другую ячейку, меняем их местами только визуально, 
# по сути список существующих предметов меньше общего инвентаря
# и в нём есть только существующие предметы
func SwapButtons(button1, button2):
	
	var button1Index = button1.get_index()
	var button2Index = button2.get_index()
	gridContainer.move_child(button1, button2Index)
	gridContainer.move_child(button2, button1Index)
	#print(items)
	#var temp_1 = items[int(button1Index)]
	#var temp_2 = items[int(button2Index)]
	#items[button1Index] = temp_2
	#items[button2Index] = temp_1

func populateButtons():
	for i in capacity:
		var packedScene = ResourceLoader.load("res://scenes/InventoryButton.tscn")
		var itemButton : Button = packedScene.instantiate()
		itemButton.connect("OnButtonClick", OnButtonClicked)
		$ScrollContainer/GridContainer.add_child(itemButton)

# Создание любого предмета в списке и отображение в инвентаре
func Add(item : Resource):
	#items.append(item)
	var currentItem = item.duplicate()
	for i in items.size():
		if items[i].ID == currentItem.ID && items[i].Quantity != currentItem.StackSize:
			if items[i].Quantity + currentItem.Quantity > items[i].StackSize:
				items[i].Quantity = currentItem.StackSize
				currentItem.Quantity = -(currentItem.Quantity - items[i].StackSize)
				UpdateButton(i)
			else:
				items[i].Quantity += currentItem.Quantity
				currentItem.Quantity = 0
				UpdateButton(i)
	if currentItem.Quantity > 0:
		if currentItem.Quantity < currentItem.StackSize:
			items.append(currentItem)
			UpdateButton(items.size() - 1)
		else:
			var tempItem = currentItem.duplicate()
			tempItem.Quantity = currentItem.StackSize
			items.append(tempItem)
			UpdateButton(items.size() - 1)
			currentItem.Quantity -= currentItem.StackSize
			Add(currentItem)

# Удаление любого предмета (осторожно, удаление происходит по порядку списка слева на право)
func Remove(item : Resource):
	var currentItem = item
	for i in items.size():
		if items[i].ID == currentItem.ID:
			if items[i].Quantity - currentItem.Quantity < 0:
				currentItem.Quantity -= items[i].Quantity
				items[i].Quantity = 0
				UpdateButton(i)
			else:
				items[i].Quantity -= currentItem.Quantity
				currentItem.Quantity = 0
				UpdateButton(i)
				
		if currentItem.Quantity <= 0:
			break
	var tempItems = items.duplicate()
	var offset = 0
	for i in tempItems.size():
		if items[i - offset].Quantity == 0:
			items.remove_at(i)
			offset += 1
	reflowButtons()

# Перепрогрузка кнопочек(ячеек) инвентаря
func reflowButtons():
	for i in capacity:
		UpdateButton(i)

# Прогрузка кнопки(ячейки) (одной из многих в инвентаря)
func UpdateButton(index : int):
	if range(items.size()).has(index):
		gridContainer.get_child(index).UpdateItem(items[index], index)
	else:
		gridContainer.get_child(index).UpdateItem(null, index)
	

# Тык по любой пустой ячейке инвентаря
func OnButtonClicked(index, currentItem):
	print("Clicked!")

# ДОБАВЛЯЮ ПРЕДМЕТ БЛЯТЬ, ВОТ ТАК СУКА НЕ ЗАБУДЬ КОГДА БУДЕШТ ДЕЛАТЬ ПОДБОР ХУЙНИ!!!!1
func _on_button_button_down() -> void:
	Add(ResourceLoader.load("res://Testitem.tres"))
	pass # Replace with function body.

# А ТАК ИХ УДАЛЯЕМ БЛЯТЬ
func _on_button_2_button_down() -> void:
	Remove(ResourceLoader.load("res://Testitem.tres"))
	pass # Replace with function body.


func _on_mouse_area_area_entered(area: Area2D) -> void:
	hoveredButton = area.get_parent()
	pass # Replace with function body.


func _on_mouse_area_area_exited(area: Area2D) -> void:
	hoveredButton = null
	pass # Replace with function body.
