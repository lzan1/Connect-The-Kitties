extends Control

var pointer = load("res://Assets/Pictures/pointinghand_100160.png")



func _on_button_mouse_entered():
	Input.set_custom_mouse_cursor(pointer,Input.CURSOR_ARROW)

func _on_button_mouse_exited():
	Input.set_custom_mouse_cursor(null)

func _on_ok_pressed():
	get_tree().paused = false
	self.hide()
