extends Node

signal scene_play
var pointer = load("res://Assets/Pictures/pointinghand_100160.png")
@onready var icon = $Control/Icon

func _ready():
	pass

func _on_button_mouse_entered():
	Input.set_custom_mouse_cursor(pointer,Input.CURSOR_ARROW)
	icon.animation = "hovered"


func _on_button_mouse_exited():
	Input.set_custom_mouse_cursor(null)
	icon.animation = "default"

func get_next():
	return preload("res://Player Select/PlayerSelect.tscn")

func _on_button_pressed():
	print("MENU get_parent:"+ str(self.get_parent().get_parent()))
	scene_play.emit()
	#emit_signal("scene_play")
	#get_tree().change_scene_to_file("res://Player Select/PlayerSelect.tscn")

func _on_control_mouse_entered():
	Input.set_custom_mouse_cursor(pointer,Input.CURSOR_ARROW)
	icon.animation = "hovered"


func _on_control_mouse_exited():
	Input.set_custom_mouse_cursor(null)
	icon.animation = "default"
