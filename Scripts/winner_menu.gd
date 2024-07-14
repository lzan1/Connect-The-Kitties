extends Control
var pointer = load("res://Assets/Pictures/pointinghand_100160.png")
@onready var pname_display = $Control/NameDisplay
signal play_again
signal main_menu
@onready var winner_cat = $Control/Control/winner_cat
@onready var sprite_2d_3 = $Control/Control/Sprite2D3
@onready var sprite_2d_2 = $Control/Control/Sprite2D2

func _on_mouse_entered():
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_ARROW)

func _on_button_mouse_exited():
	Input.set_custom_mouse_cursor(null)

func display_winner(pname):
	pname_display.text = pname.to_upper()

func display_cat(texture):
	winner_cat.texture = texture

func _on_play_again_pressed():
	get_tree().paused = false
	play_again.emit()

func _on_main_menu_pressed():
	get_tree().paused = false
	main_menu.emit()

func _on_timer_timeout():
	sprite_2d_3.animation = "default"
	sprite_2d_3.play("default")


func _on_timer_2_timeout():
	sprite_2d_2.play("default")
