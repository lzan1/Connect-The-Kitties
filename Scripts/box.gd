extends StaticBody2D
const area2d = preload("res://Main_Game/area_2d.tscn")
@onready var box_area = $Area2D
var num_columns = 7

# Called when the node enters the scene tree for the first time.
func _ready():
	var box_width = get_box_dimensions().x
	var box_height = get_box_dimensions().y
	var column_width = box_width/num_columns - 5
	var column_height = box_height + self.position.y
	print("width" + str(column_width) + "height: " + str(column_height))
	for i in range(1,num_columns+1):
		var inst = inst_area2d(column_width,column_height, i-1)
		#position_area2d(column_width*i+(self.position.x-box_width/2-63),self.position.y - (column_height-box_height+40)/2,inst)
		#position_area2d(column_width*(i-4),-125,inst)
		position_area2d(column_width*(i-4)+4, -20,inst)
		get_parent().get_parent().area2d_arr.append(inst)
		get_parent().get_parent().area2d_dict[inst] = i-1
		add_child(inst)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_box_dimensions():
	var width = box_area.texture.get_width() * box_area.scale.x
	var height = box_area.texture.get_height() * box_area.scale.y
	return Vector2(width, height)
	
func inst_area2d(width, height, index):
	var instance = area2d.instantiate()
	instance.get_node("CollisionShape2D").shape.set_size(Vector2(width, height))
	instance.col_num = index
	return instance
	
func position_area2d(x,y, area):
	area.position = Vector2(x,y)

func set_num_cols(num):
	num_columns = num
