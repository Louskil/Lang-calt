class_name _Inventory

var _content:Array[_Item] = []

func add_item(item: _Item):
	if !item in _content:
		_content.append(item)
		_content[_content.find(item, 0)].Quantity += 1
	elif not _content[_content.find(item, 0)].Quantity + 1 > item.StackSize:
		_content[_content.find(item, 0)].Quantity += 1
	
func remove_item(item: _Item):
	if not item in _content:
		print("IDI NAHUY")
	elif item in _content:
		if item.Quantity - 1 > 0:
			item.Quantity - 1
		else: 
			_content.pop_at(_content.find(item, 0))

func get_items():
	return _content

func _test_get_items():
	for i: _Item in _content:
		print(i.Name)
		print(i.Quantity)
