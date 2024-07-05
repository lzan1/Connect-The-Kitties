extends CharacterBody2D
@onready var box = self.get_parent().get_node("%box")
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
signal touched_floor 
signal hide_background
var release
@onready var box_width = get_box_dimensions().x
@onready var num_columns = self.get_parent().num_columns
var column_width
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var active
@onready var box_pos = get_box_pos()

func _ready():
	release = false
	active = true
	column_width = box_width/num_columns

func _physics_process(delta):
	# Add the gravity.
	if Input.is_action_just_pressed("ui_select"):
		release = true
	if release:
		hide_background.emit()
		if not is_on_floor():
			velocity.y += gravity * delta*2
		else:
			active = false
			touched_floor.emit()
	else:
		var direction = Input.get_axis("ui_left", "ui_right")
		if Input.is_action_just_pressed("ui_left") and (position.x > (box_pos.x-box_width/2 + column_width)):
			position.x += column_width*direction
		if Input.is_action_just_pressed("ui_right") and (position.x < (box_pos.x+box_width/2 - column_width)):
			position.x += column_width*direction
		#if direction:
			#position.x += 20*direction
			##velocity.x = direction * SPEED
		#else:
			#velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func get_box_dimensions():
	#var width = 3
	var width = box.get_node("Area2D").texture.get_width() * box.get_node("Area2D").scale.x
	var height = box.get_node("Area2D").texture.get_height() * box.get_node("Area2D").scale.y
	#print( box.get_node("Area2D").texture.get_width())
	#print(box.get_node("Area2D").scale.x)
	return Vector2(width, height)
	
func get_box_pos():
	#var width = 3
	var x = box.position.x
	var y = box.position.y
	#print( box.get_node("Area2D").texture.get_width())
	#print(box.get_node("Area2D").scale.x)
	print("box position:" + str(x))
	return Vector2(x, y)

#
#func _on_area_2d_2_area_entered(area):
	#pass # Replace with function body.
