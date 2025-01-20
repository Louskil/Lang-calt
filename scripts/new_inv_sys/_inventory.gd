class_name _Inventory

var _content:Array[_Item] = []

func add_item(item: _Item): 
	_content.append(item)
	
func remove_item(item: _Item):
	_content.erase(item)

func get_items(item: _Item):
	return _content
