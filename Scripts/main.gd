extends Node
var main_menu = preload("res://Main_Menu/MainMenu.tscn")
var player_select = preload("res://Player Select/PlayerSelect.tscn")
var bkg_select = preload("res://Background_Select/BackgroundSelect.tscn")
var main_game = preload("res://Main_Game/game.tscn")
@onready var main = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	var curr_scene = main_menu.instantiate()
	add_child(curr_scene)
	var node_with_signal = curr_scene.get_node("play_button")
	node_with_signal.scene_play.connect(menu_to_char.bind(node_with_signal))
	#Checks if scene_play is connected, all return true
	print(node_with_signal.get_signal_connection_list("scene_play"))
	print(node_with_signal.scene_play.is_connected(menu_to_char))

func menu_to_char(scene):
	scene.get_owner().queue_free()
	print(is_instance_valid(scene))

