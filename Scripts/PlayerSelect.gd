extends Node
var pointer = load("res://Assets/Pictures/pointinghand_100160.png")
signal player_selected(p1, p2, p1_name, p2_name)
signal backMain
signal nextBkg
@onready var cat_label_1 = $Control2/Player1/CatLabel1
@onready var cat_label_2 = $Control2/Player2/CatLabel2
@onready var line_edit_1 = $Control2/Player1/LineEdit1
@onready var line_edit_2 = $Control2/Player2/LineEdit2
@onready var diff_cat_menu = $DiffCatMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	diff_cat_menu.hide()

func _on_back_mouse_entered():
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_ARROW)


func _on_back_mouse_exited():
	Input.set_custom_mouse_cursor(null)


func _on_next_mouse_entered():
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_ARROW)

func _on_next_mouse_exited():
	Input.set_custom_mouse_cursor(null)


func _on_next_pressed():
	var p1 = cat_label_1.get_p1_cat()
	var p2 = cat_label_2.get_p2_cat()
	var p1_name = line_edit_1.text
	var p2_name = line_edit_2.text
	if p1 == p2 or p1_name == p2_name:
		diff_cat_menu.show()
	else:
		if p1_name == "":
			p1_name = "Player 1"
		if p2_name == "":
			p2_name = "Player 2"
		player_selected.emit(p1, p2, p1_name, p2_name)
		nextBkg.emit()
		#get_tree().change_scene_to_file("res://Background_Select/BackgroundSelect.tscn")

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
	print("PLAYERSELECT current scene " + str(self))
	print("PLAYERSELECT get_parent: "+ str(self.get_parent()))
	#backMain.connect(get_parent().migrate.bind(self, preload("res://Main_Menu/MainMenu.tscn")))
	backMain.emit()
	#get_tree().change_scene_to_file("res://Main_Menu/MainMenu.tscn")
