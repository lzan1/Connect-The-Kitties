extends Node

const area2d = preload("res://Main_Game/area_2d.tscn")
const CHAR = preload("res://Main_Game/testplayer.tscn")
const player_select_scene = preload("res://Main_Game/testplayer.tscn")
@onready var box = $box

var num_columns = 7
var char_arr = ['']
var box_width 
var box_height
var p1Cat
var p2Cat
# Called when the node enters the scene tree for the first time.
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
	char_arr[0] = CHAR.instantiate()
	add_child(char_arr[0])
	char_arr[0].touched_floor.connect(on_coin_touched_floor)
	
	box_width = get_box_dimensions().x
	box_height = get_box_dimensions().y
	var column_width = box_width/num_columns
	var column_height = box_height/2 + box.position.y
	for i in range(1,num_columns+1):
		var inst = inst_area2d(column_width,column_height)
		position_area2d(column_width*i+(box.position.x-box_width/2-63),box.position.y - (column_height-box_height+2)/2,inst)
		add_child(inst)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_coin_touched_floor():
	char_arr.append(CHAR.instantiate())
	add_child(char_arr[-1])
	char_arr[-2].touched_floor.disconnect(on_coin_touched_floor)
	char_arr[-1].touched_floor.connect(on_coin_touched_floor)

func position_area2d(x,y, area):
	area.position = Vector2(x,y)
	
func get_box_dimensions():
	var width = box.get_node("Area2D").texture.get_width() * box.get_node("Area2D").scale.x
	var height = box.get_node("Area2D").texture.get_height() * box.get_node("Area2D").scale.y
	return Vector2(width, height)

#Instantiates area2d of size widith, height
func inst_area2d(width, height):
	var instance = area2d.instantiate()
	instance.get_node("CollisionShape2D").shape.set_size(Vector2(width, height))
	return instance

func on_charas_selected(p1, p2):
	p1Cat = p1
	p2Cat = p2
	print("ayayya")
	print(str(p1Cat) + str(p2Cat))
