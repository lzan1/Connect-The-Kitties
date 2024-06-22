extends Node

const area2d = preload("res://Scenes/area_2d.tscn")
const CHAR = preload("res://Scenes/testplayer.tscn")
@onready var box = $box

var num_columns = 7
var char_arr = ['']
# Called when the node enters the scene tree for the first time.
func _ready():
	#add character
	char_arr[0] = CHAR.instantiate()
	add_child(char_arr[0])
	char_arr[0].touched_floor.connect(on_coin_touched_floor)
	#instantiate area2d
	#var inst = inst_area2d(300,300)
	#position_area2d(0,0,inst)
	#add_child(inst)
	#Set up collision2d areas
	var box_width = get_box_dimensions().x
	var box_height = get_box_dimensions().y
	var column_width = box_width/num_columns
	var column_height = box_height/2 + box.position.y
	for i in range(1,num_columns+1):
		var inst = inst_area2d(column_width,column_height)
		position_area2d(column_width*i+(box.position.x-box_width/2-20),box.position.y - (column_height-box_height-40)/2,inst)
		add_child(inst)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_coin_touched_floor():
	char_arr.append('')
	char_arr[-1] = CHAR.instantiate()
	add_child(char_arr[-1])
	char_arr[-2].touched_floor.disconnect(on_coin_touched_floor)
	char_arr[-1].touched_floor.connect(on_coin_touched_floor)

func position_area2d(x,y, area):
	area.position = Vector2(x,y)
	
func get_box_dimensions():
	#var width = 3
	var width = box.get_node("Area2D").texture.get_width() * box.get_node("Area2D").scale.x
	var height = box.get_node("Area2D").texture.get_height() * box.get_node("Area2D").scale.y
	#print( box.get_node("Area2D").texture.get_width())
	#print(box.get_node("Area2D").scale.x)
	return Vector2(width, height)

#Instantiates area2d of size widith, height
func inst_area2d(width, height):
	var instance = area2d.instantiate()
	instance.get_node("CollisionShape2D").shape.set_size(Vector2(width, height))
	return instance
