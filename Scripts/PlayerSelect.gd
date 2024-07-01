extends Node
var pointer = load("res://Assets/Pictures/pointinghand_100160.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_mouse_entered():
	Input.set_custom_mouse_cursor(pointer,Input.CURSOR_ARROW)


func _on_back_mouse_exited():
	Input.set_custom_mouse_cursor(null)


func _on_next_mouse_entered():
	Input.set_custom_mouse_cursor(pointer,Input.CURSOR_ARROW)


func _on_next_mouse_exited():
	Input.set_custom_mouse_cursor(null)


func _on_next_pressed():
	get_tree().change_scene_to_file("res://Background_Select/BackgroundSelect.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Main_Menu/MainMenu.tscn")
