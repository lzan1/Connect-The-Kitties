extends Node
var pointer = load("res://Assets/Pictures/pointinghand_100160.png")
@onready var bkg_carousel = $BkgCarousel
signal envi_selected(envi)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_mouse_entered():
	Input.set_custom_mouse_cursor(pointer,Input.CURSOR_ARROW)


func _on_button_mouse_exited():
	Input.set_custom_mouse_cursor(null)


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Player Select/PlayerSelect.tscn")


func _on_play_pressed():
	var curr_scene = bkg_carousel.get_curr_scene()
	envi_selected.emit(curr_scene)
	get_tree().change_scene_to_file("res://Main_Game/game.tscn")
