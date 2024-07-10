extends Node

const area2d = preload("res://Main_Game/area_2d.tscn")
const CHAR = preload("res://Main_Game/testplayer.tscn")
const player_select_scene = preload("res://Main_Game/testplayer.tscn")
@onready var box = %box
@onready var label = $TurnIndicator/Label

var num_columns = 7
var num_rows = 8
var area2d_arr = []
var area2d_dict = {}
var table_arr = []
var char_p1_arr = ['']
var char_p2_arr = ['']
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
	
	#add character
	char_p1_arr[0] = CHAR.instantiate()
	char_p1_arr[-1].get_node("Sprite").texture = p1Cat
	add_child(char_p1_arr[0])
	char_p1_arr[0].touched_floor.connect(on_coin_touched_floor)
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

func _process(delta):
	pass

func on_coin_touched_floor():
	turn += 1
	var col_dropped_index
	var row_index
	change_indicator()
	if turn%2 == 0:
		#Add new p2 cat
		char_p2_arr.append(CHAR.instantiate())
		add_child(char_p2_arr[-1])
		char_p2_arr[-1].get_node("Sprite").texture = p2Cat
		#Get col index of last cat
		col_dropped_index = area2d_dict[char_p1_arr[-1].get_curr_col()]
		char_p1_arr[-1].touched_floor.disconnect(on_coin_touched_floor)
		char_p2_arr[-1].touched_floor.connect(on_coin_touched_floor)
		row_index = get_dropped_row(col_dropped_index)
		table_arr[row_index][col_dropped_index] = 1
		if detect_row_win(1) or detect_col_win(1):
			print("Winner is player 1!")
	else:
		#Add new p1 cat
		char_p1_arr.append(CHAR.instantiate())
		add_child(char_p1_arr[-1])
		char_p1_arr[-1].get_node("Sprite").texture = p1Cat
		#Get col index of last cat
		col_dropped_index = area2d_dict[char_p2_arr[-1].get_curr_col()]
		char_p2_arr[-1].touched_floor.disconnect(on_coin_touched_floor)
		char_p1_arr[-1].touched_floor.connect(on_coin_touched_floor)
		row_index = get_dropped_row(col_dropped_index)
		table_arr[row_index][col_dropped_index] = 2
		if detect_row_win(2) or detect_col_win(2):
			print("Winner is player 2!")
	#Get row index of last cat
	
	#TODO: If row_index == -1, don't let cat be dropped
	#Add cat placement to overall table
	
	for i in table_arr:
		print(str(i))

func get_turn():
	if turn%2 == 0:
		return "p2"
	return "p1"

func detect_row_win(num):
	
	var count
	for row in table_arr:
		count = 0
		for el in row:
			if count >= 4:
				return true
			elif el == num:
				count += 1
			else:
				count = 0
			
func detect_col_win(num):
	var count 
	for col_i in range(num_columns):
		count = 0
		for row_i in range(num_rows):
			print("row number:"+str(row_i))
			if count >= 4:
				return true
			elif table_arr[row_i][col_i] == num:
				count += 1
				print("row number:"+str(row_i))
				print(count)
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
	print(instance.col_num)
	return instance

func set_names(p1, p2):
	p1Name = p1
	p2Name = p2
