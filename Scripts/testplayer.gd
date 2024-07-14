extends CharacterBody2D
@onready var box = self.get_parent().get_node("%box")
const SPEED = 300.0
signal touched_floor 
signal hide_background
@onready var box_width = get_box_dimensions().x
@onready var num_columns = self.get_parent().get_parent().num_columns
var column_width
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var release
var active
var curr_column
var self_pos = self.position
var settled = false
@onready var box_pos = get_box_pos()
@onready var whistle = $whistle
var play = true

func _ready():
	#self.position = Vector2(635,142)
	release = false
	active = true
	column_width = box_width/num_columns

func _physics_process(delta):
	# Add the gravity.
	if Input.is_action_just_pressed("ui_select"):
		release = true
	if release:
		if check_releasable():
			if play:
				whistle.play()
				play = false
			hide_background.emit()
			if not is_on_floor():
				velocity.y += gravity * delta * 3
			else:
				active = false
				settled = true
				touched_floor.emit()
		else:
			release = false
	elif !settled:
		var direction = Input.get_axis("ui_left", "ui_right")
		if Input.is_action_just_pressed("ui_left") and (position.x > (box_pos.x-box_width/2 + column_width)):
			position.x += column_width*direction
			curr_column = get_parent().get_parent().get_next(curr_column,-1)
		if Input.is_action_just_pressed("ui_right") and (position.x < (box_pos.x+box_width/2 - column_width)):
			position.x += column_width*direction
			curr_column = get_parent().get_parent().get_next(curr_column,1)
		#if direction:
			#position.x += 20*direction
			##velocity.x = direction * SPEED
		#else:
			#velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func check_releasable():
	return get_parent().get_parent().check_col_full(curr_column)

func get_box_dimensions():
	#var width = 3
	var width = box.get_node("Area2D").texture.get_width() * box.get_node("Area2D").scale.x
	var height = box.get_node("Area2D").texture.get_height() * box.get_node("Area2D").scale.y
	return Vector2(width, height)
	
func get_box_pos():
	#var width = 3
	var x = box.position.x
	var y = box.position.y
	return Vector2(x, y)

func get_curr_col():
	return curr_column
