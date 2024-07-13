extends Node
var main_menu = preload("res://Main_Menu/MainMenu.tscn")
var player_select = preload("res://Player Select/PlayerSelect.tscn")
var bkg_select = preload("res://Background_Select/BackgroundSelect.tscn")
var main_game = preload("res://Main_Game/game.tscn")
@onready var main = $"."
var p1_name := "Player 1"
var p2_name := "Player 2"
var display_envi
var display_p1
var display_p2
var curr_scene
var node_with_signal
var ya

# Called when the node enters the scene tree for the first time.
func _ready():
	curr_scene = main_menu.instantiate()
	add_child(curr_scene)
	node_with_signal = curr_scene.get_node("play_button")
	node_with_signal.scene_play.connect(change_scene.bind(curr_scene, player_select))
	#for i in range(3):
		#var curr = main_menu.instantiate()
		#print(curr.name)
		#curr.queue_free()
		#curr = main_menu.instantiate()
		#print(curr.name)

func change_scene(fromHere, toHere):
	migrate(fromHere, toHere)
	match_scene()

func match_scene():
	match curr_scene.name:
		"MainMenu":
			node_with_signal = curr_scene.get_node("play_button")
			node_with_signal.scene_play.connect(change_scene.bind(curr_scene, player_select))
		"PlayerSelect":
			node_with_signal = curr_scene
			node_with_signal.player_selected.connect(set_player)
			node_with_signal.backMain.connect(change_scene.bind(player_select, main_menu))
			#node_with_signal = curr_scene.get_node("NextControl")
			node_with_signal.nextBkg.connect(change_scene.bind(player_select, bkg_select))
		"BackgroundSelect":
			node_with_signal = curr_scene
			node_with_signal.envi_selected.connect(set_background)
			node_with_signal.backPlayer.connect(change_scene.bind(bkg_select, player_select))
			node_with_signal.nextPlay.connect(change_scene.bind(bkg_select, main_game))
		"Game":
			print("Inside game")
			print("name 1: " + str(p1_name))
			print("name 2: " + str(p2_name))
			curr_scene.get_node("Environment").texture = display_envi
			curr_scene.get_node("CharacterBody2D").get_node("Sprite").texture = display_p1
			curr_scene.get_node("CharacterBody2D").position = Vector2(635,142)
			curr_scene.get_node("TurnIndicator").get_node("Label").text = str(p1_name).to_upper() + "'S TURN"
			curr_scene.p1Cat = display_p1
			curr_scene.p2Cat = display_p2
			curr_scene.set_names(p1_name, p2_name)
			node_with_signal = curr_scene.get_node("winner_menu")
			node_with_signal.play_again.connect(change_scene.bind(main_game,main_game))
			node_with_signal.main_menu.connect(change_scene.bind(main_game,main_menu))
			print(curr_scene.get_node("CharacterBody2D").position)

func migrate(fromHere, toHere):
	if fromHere == toHere:
		print("In fromHere == toHere")
		curr_scene.name = str(curr_scene.name) + "1"
		curr_scene.queue_free()
		curr_scene = toHere.instantiate()
		add_child(curr_scene)
	else:
		curr_scene.queue_free()
		print("self get children after FREE: "+str(self.get_children()))
		curr_scene = toHere.instantiate()
		add_child(curr_scene)
		print("self get children after adding child: "+str(self.get_children()))
	#print("curr scene after: "+str(curr_scene.name))
	#print("MAIN current scene"+str(curr_scene))
	#print("MAIN current scene get_parent:" + str(curr_scene.get_parent()))
	#print(self.get_children())

	
func set_background(curr_envi):
	display_envi = curr_envi

func set_player(p1, p2, p1_n, p2_n):
	display_p1 = p1
	display_p2 = p2
	p1_name = p1_n
	p2_name = p2_n
	
