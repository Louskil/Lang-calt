extends Resource
class_name Item

@export var ID : int
@export var Name : String
@export var ResourcePath : String
@export var Icon : Texture2D
@export var Quantity : int
@export var StackSize : int
@export var IsStackable : bool
@export var Scene: PackedScene
#@export var Weight : float
#@export var SubItem : Item
#@export var SubItemFound : bool
#@export var DeleteItemAfterFound : bool
#@export var AfterFoundBaseItem : Item
#@export var ItemCraftableMakeup : Dictionary # item, required amount

func UseItem():
	print("Used Item!")
	pass
