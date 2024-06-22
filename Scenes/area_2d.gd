extends Area2D
@onready var background = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	background.hide()

func _on_body_entered(body):
	if "CharacterBody2D" in body.name:
		#body.touched_floor.connect(background.hide)
		#print("background hidden")
		
		if body.active:
			print("Entering area2d")
			background.show()
			body.touched_floor.connect(background.hide)
			#body.touched_floor.disconnect(background.hide)
		#else:
			#print("Not active. hiding")
			#background.hide()


func _on_body_exited(body):
	if "CharacterBody2D" in body.name:
		#print("oo")
		background.hide()
