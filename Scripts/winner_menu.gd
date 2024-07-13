extends Control
var pointer = load("res://Assets/Pictures/pointinghand_100160.png")
@onready var name_display = $Control/NameDisplay
signal play_again
signal main_menu
@onready var winner_cat = $Control/Control/winner_cat

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	Input.set_custom_mouse_cursor(pointer,Input.CURSOR_ARROW)

func _on_button_mouse_exited():
	Input.set_custom_mouse_cursor(null)

func display_winner(name):
	name_display.text = name.to_upper()

func display_cat(texture):
	winner_cat.texture = texture

func _on_play_again_pressed():
	play_again.emit()


func _on_main_menu_pressed():
	main_menu.emit()
