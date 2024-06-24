extends Area2D
@onready var background = $Sprite2D
var arr = []
# Called when the node enters the scene tree for the first time.
func _ready():
	background.hide()

#func _process(_delta):
	#if !body.active:
		#background.hide()

func _on_body_exited(body):
	if body is CharacterBody2D:
		print(str(body.name) + " Body exited")
		background.hide()
		body.hide_background.disconnect(ay)

func _on_body_entered(body):
	if body is CharacterBody2D and body.active:
		print(body.name + "entered")
		#body.set_collision_layer_value(1,true)
		#body.set_collision_mask_value(1,true)
		background.show()
		body.hide_background.connect(ay.bind(body))

func ay(body):
	#arr.append(body)
	print("floor touched by" + str(body.name))
	#bkg.hide()
	body.set_collision_layer_value(1,false)
	body.set_collision_layer_value(2,true)
	body.set_collision_mask_value(1,false)
	body.hide_background.disconnect(ay)


