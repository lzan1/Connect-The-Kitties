extends Control
var pointer = load("res://Assets/Pictures/pointinghand_100160.png")

signal play_again_tie
signal main_menu_tie


func _on_mouse_entered():
	Input.set_custom_mouse_cursor(pointer,Input.CURSOR_ARROW)
	

func _on_main_menu_mouse_exited():
	Input.set_custom_mouse_cursor(null)


func _on_play_again_pressed():
	get_tree().paused = false
	play_again_tie.emit()

func _on_main_menu_pressed():
	get_tree().paused = false
	main_menu_tie.emit()
