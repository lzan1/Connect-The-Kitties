extends Node
@onready var character_body_2d = $CharacterBody2D

const CHAR = preload("res://Scenes/testplayer.tscn")
var char_inst
var touched
var char_arr = ['']
# Called when the node enters the scene tree for the first time.
func _ready():
	char_arr[0] = CHAR.instantiate()
	add_child(char_arr[0])
	print(char_arr[0].SPEED)
	char_arr[0].touched_floor.connect(on_coin_touched_floor)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("///////////////////////")

func on_coin_touched_floor():
	char_arr.append('')
	char_arr[-1] = CHAR.instantiate()
	add_child(char_arr[-1])
	char_arr[-2].touched_floor.disconnect(on_coin_touched_floor)
	char_arr[-1].touched_floor.connect(on_coin_touched_floor)
