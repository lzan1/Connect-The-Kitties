extends Node
var pointer = load("res://Assets/Pictures/pointinghand_100160.png")
@onready var bkg_carousel = $BkgCarousel
signal envi_selected(envi)
signal backPlayer
signal nextPlay

func _on_button_mouse_entered():
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_ARROW)


func _on_button_mouse_exited():
	Input.set_custom_mouse_cursor(null)


func _on_back_pressed():
	backPlayer.emit()
	#get_tree().change_scene_to_file("res://Player Select/PlayerSelect.tscn")


func _on_play_pressed():
	var curr_envi = bkg_carousel.get_curr_scene()
	envi_selected.emit(curr_envi)
	nextPlay.emit()
	#get_tree().change_scene_to_file("res://Main_Game/game.tscn")
