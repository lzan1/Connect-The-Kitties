extends Node
var area2d = preload("res://burner/area_2d.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var inst = inst_area2d(100,100)
	position_area2d(0,0,inst)
	#print(inst.position)
	add_child(inst)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
	
func position_area2d(x,y, area):
	area.position = Vector2(x,y)
	

#Instantiates area2d of size widith, height
func inst_area2d(width, height):
	var instance = area2d.instantiate()
	instance.get_node("CollisionShape2D").shape.set_size(Vector2(width, height))
	return instance
	#add_child(instance)
	#print(instance.get_node("CollisionShape2D").shape.size)
