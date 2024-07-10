extends Area2D
@onready var background = $Sprite2D
var col_num
# Called when the node enters the scene tree for the first time.
func _ready():
	background.hide()

#func _process(_delta):
	#if !body.active:
		#background.hide()

func _on_body_exited(body):
	if body is CharacterBody2D:
		#print(is_connected("hide_background", bkg_appear))
		#body.hide_background.disconnect(bkg_appear)
		background.hide()

func _on_body_entered(body):
	if body is CharacterBody2D and body.active:
		body.curr_column = self
		background.show()
		body.hide_background.connect(bkg_appear.bind(body))

func bkg_appear(body):
	#bkg.hide()
	body.set_collision_layer_value(1,false)
	body.set_collision_layer_value(2,true)
	body.set_collision_mask_value(1,false)
	body.hide_background.disconnect(bkg_appear)
	
func get_col_num():
	return col_num


