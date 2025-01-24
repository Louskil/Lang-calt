class_name Inventory

var content:Array[Item] = []

func add_item(item: Item):
	if !item in content:
		content.append(item)
		content[content.find(item, 0)].Quantity += 1
	elif not content[content.find(item, 0)].Quantity + 1 > item.StackSize:
		content[content.find(item, 0)].Quantity += 1
	
func remove_item(item: Item):
	if not item in content:
		print("IDI NAHUY")
	elif item in content:
		if item.Quantity - 1 > 0:
			item.Quantity - 1
		else: 
			content.pop_at(content.find(item, 0))

func get_items():
	return content

func _test_get_items():
	for i: Item in content:
		print(i.Name)
		print(i.Quantity)
