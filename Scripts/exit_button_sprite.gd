extends AnimatedSprite2D

var pointer = load("res://Assets/Pictures/pointinghand_100160.png")

func _on_control_mouse_entered():
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_ARROW)
	self.animation = "hovered"


func _on_control_mouse_exited():
	Input.set_custom_mouse_cursor(null)
	self.animation = "default"


func _on_button_mouse_entered():
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_ARROW)
	self.animation = "hovered"


func _on_button_mouse_exited():
	Input.set_custom_mouse_cursor(null)
	self.animation = "default"


func _on_button_pressed():
	get_tree().quit()
