extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func startButton() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
	
func Quit_pressed() -> void:
	get_tree().quit()


func options_pressed() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
