extends Node
var pointer = load("res://Assets/Pictures/pointinghand_100160.png")
signal charas_selected(p1, p2)
@onready var cat_label_1 = $Player1/CatLabel1
@onready var cat_label_2 = $Player2/CatLabel2

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
	var p1 = cat_label_1.get_p1_cat()
	var p2 = cat_label_2.get_p2_cat()
	charas_selected.emit(p1, p2)
	get_tree().change_scene_to_file("res://Background_Select/BackgroundSelect.tscn")

#1st way:
# Make signal
# Delete (queue_free main menu, then select scenes)
#2nd way:
#Global way
#- You can do autoload, not best practice (make a couple, learn yourself)
#- Not reliable, spaghetti code, messy
#- OR Have resources (player name, player color)
#- OR have project files
#- Image you have player. THat player has a resource stored in variable (eg.,mystats)
#  Once you change mystats, (eg. player edits)


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Main_Menu/MainMenu.tscn")
