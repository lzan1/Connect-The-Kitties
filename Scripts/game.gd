extends Node

@onready var win_sound = $win_sound
@onready var tie_sound = $tie_sound

@onready var tied_menu = $tied_menu
@onready var winner_menu = $winner_menu
const area2d = preload("res://Main_Game/area_2d.tscn")
const CHAR = preload("res://Main_Game/testplayer.tscn")
const player_select_scene = preload("res://Main_Game/testplayer.tscn")
@onready var box = %box
@onready var label = $TurnIndicator/Label
var a = true
@onready var character_body_2d = $CharacterBody2D
signal pause

var num_columns = 7
var num_rows = 8
var area2d_arr = []
var area2d_dict = {}
var table_arr = []
var char_p1_arr = []
var char_p2_arr = []
var box_width 
var box_height
var p1Cat
var p1Name
var p2Cat
var p2Name
var turn := 1

"""
TODO: Make sure cursor size is same for all platforms
	Make sure player name and cat texture display on the first turn for all possible names/textures
"""


func _ready():
	#Add character types
	#player_select_scene.instantiate().charas_selected.connect(on_charas_selected)
	#Should use autoload?
	#Autoload creates automatic runtime tat is accessible form every scene in the project
	#When you write 'Input', you're using the Input autoload
	#You can write your own autoloads/scripts/classes where you write down the name of that autoload & use its data
	#Autoloads are more for core-of-the-project
	#Signals are better for little scenes far down the tree (eg. character walks into area)
	winner_menu.hide()
	#add character
	char_p1_arr.append(character_body_2d)
	#add_child(char_p1_arr[-1])
	#char_p1_arr[-1].position = Vector2(635,142)
	char_p1_arr[-1].get_node("Sprite").texture = p1Cat
	char_p1_arr[-1].touched_floor.connect(on_coin_touched_floor)
	#initialize area2d bkgs
	box_width = get_box_dimensions().x
	box_height = get_box_dimensions().y
	var column_width = box_width/num_columns
	var column_height = box_height/2 + box.position.y
	for i in range(1,num_columns+1):
		var inst = inst_area2d(column_width,column_height, i-1)
		position_area2d(column_width*i+(box.position.x-box_width/2-63),box.position.y - (column_height-box_height+40)/2,inst)
		area2d_arr.append(inst)
		area2d_dict[inst] = i-1
		add_child(inst)
	
	#initialize array 
	for i in range(num_rows):
		var new_row = []
		for j in range(num_columns):
			new_row.append(0)
		table_arr.append(new_row)
	char_p1_arr[-1].position = Vector2(635,142)

	
func on_coin_touched_floor():
	turn += 1
	var col_dropped_index
	var row_index
	change_indicator()
	if turn%2 == 0:
		#Add new p2 cat
		char_p2_arr.append(CHAR.instantiate())
		add_child(char_p2_arr[-1])
		char_p2_arr[-1].position = Vector2(635,142)
		char_p2_arr[-1].get_node("Sprite").texture = p2Cat
		char_p2_arr[-1].curr_column = area2d_dict.find_key(3)
		#Get col index of last cat
		col_dropped_index = area2d_dict[char_p1_arr[-1].get_curr_col()]
		char_p1_arr[-1].touched_floor.disconnect(on_coin_touched_floor)
		char_p2_arr[-1].touched_floor.connect(on_coin_touched_floor)
		row_index = get_dropped_row(col_dropped_index)
		table_arr[row_index][col_dropped_index] = 1
		if detect_row_win(1) or detect_col_win(1) or detect_diag_win(1):
			win(p1Name, p1Cat)
	else:
		#Add new p1 cat
		char_p1_arr.append(CHAR.instantiate())
		add_child(char_p1_arr[-1])
		char_p1_arr[-1].position = Vector2(635,142)
		char_p1_arr[-1].get_node("Sprite").texture = p1Cat
		char_p1_arr[-1].curr_column = area2d_dict.find_key(3)
		#Get col index of last cat
		col_dropped_index = area2d_dict[char_p2_arr[-1].get_curr_col()]
		char_p2_arr[-1].touched_floor.disconnect(on_coin_touched_floor)
		char_p1_arr[-1].touched_floor.connect(on_coin_touched_floor)
		row_index = get_dropped_row(col_dropped_index)
		table_arr[row_index][col_dropped_index] = 2
		if detect_row_win(2) or detect_col_win(2) or detect_diag_win(2):
			win(p2Name, p2Cat)
	if board_full():
		tie(p1Cat,p2Cat)

func board_full():
	for row in table_arr:
		for el in row:
			if el == 0:
				return false
	return true

func tie(cat1, cat2):
	tie_sound.play()
	tied_menu.get_node("Control/Control/p1_cat").texture = cat1
	tied_menu.get_node("Control/Control/p2_cat").texture = cat2
	tied_menu.show()
	get_tree().paused = true

func detect_diag_win(num):
	for row in range(0,num_rows - 3):
		for col in range(0, num_columns):
			if col ==3:
				if detect_diag_RL(row, col, num) or detect_diag_LR(row, col, num):
					return true
			elif col < 3:
				if detect_diag_LR(row, col, num):
					return true
			else:
				if detect_diag_RL(row, col, num):
					return true
			
func win(winner_name, winner_cat):
	win_sound.play()
	winner_menu.display_winner(winner_name)
	winner_menu.display_cat(winner_cat)
	winner_menu.show()
	winner_menu.get_node("Timer").start()
	winner_menu.get_node("Timer2").start()
	get_tree().paused = true
	
func detect_diag_LR(start_r, start_c, num):
	if table_arr[start_r][start_c] == num && (table_arr[start_r][start_c] == table_arr[start_r+1][start_c+1]
										&& table_arr[start_r+1][start_c+1] == table_arr[start_r+2][start_c+2]
										&& table_arr[start_r+2][start_c+2] == table_arr[start_r+3][start_c+3]):
		return true

func detect_diag_RL(start_r, start_c, num):
	if table_arr[start_r][start_c] == num && (table_arr[start_r][start_c] == table_arr[start_r+1][start_c-1]
										&& table_arr[start_r+1][start_c-1] == table_arr[start_r+2][start_c-2]
										&& table_arr[start_r+2][start_c-2] == table_arr[start_r+3][start_c-3]):
		return true
		
func detect_row_win(num):
	var count
	for row in table_arr:
		count = 0
		for el in row:
			if count >= 4:
				return true
			elif el == num:
				count += 1
				if count >= 4:
					return true
			else:
				count = 0
			
func detect_col_win(num):
	var count 
	for col_i in range(num_columns):
		count = 0
		for row_i in range(num_rows):
			if count >= 4:
				return true
			elif table_arr[row_i][col_i] == num:
				count += 1
				if count >= 4:
					return true
			else:
				count = 0
		
func change_indicator():
	if turn%2==0:
		label.text = str(p2Name).to_upper() + "'S TURN"
	else:
		label.text = str(p1Name).to_upper() + "'S TURN"

func get_dropped_row(col):
	var dropped_row = 0
	for row_i in range(num_rows-1,-1,-1):
		if table_arr[row_i][col] == 0:
			dropped_row = row_i
			return dropped_row
	return -1

func position_area2d(x,y, area):
	area.position = Vector2(x,y)
	
func get_box_dimensions():
	var width = box.get_node("Area2D").texture.get_width() * box.get_node("Area2D").scale.x
	var height = box.get_node("Area2D").texture.get_height() * box.get_node("Area2D").scale.y
	return Vector2(width, height)

#Instantiates area2d of size widith, height
func inst_area2d(width, height, index):
	var instance = area2d.instantiate()
	instance.get_node("CollisionShape2D").shape.set_size(Vector2(width, height))
	instance.col_num = index
	return instance

func set_names(p1, p2):
	p1Name = p1
	p2Name = p2

func get_next(col, dir):
	var ind = area2d_dict[col]
	return area2d_dict.find_key(ind + dir)

func check_col_full(col):
	var ind = area2d_dict[col]
	for row in range(num_rows):
		if table_arr[row][ind] == 0:
			return true
	return false
