extends Sprite2D
@onready var collision_shape_2d = $"../CollisionShape2D"

# Called when the node enters the scene tree for the first time.
func _ready():
	#texture
	var collision_x = get_collion_size().x
	var collision_y = get_collion_size().y
	scale.x = collision_x/texture.get_size().x
	scale.y = collision_y/texture.get_size().y
	#print(name)
	#print(position.x)
	#print(texture.get_size()) # Replace with function body.

func get_collion_size():
	return collision_shape_2d.shape.get_size()
	
	
