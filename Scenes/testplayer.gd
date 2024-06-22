extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var release = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
signal touched_floor
var active = true;

func _physics_process(delta):
	
	# Add the gravity.
	if Input.is_action_just_pressed("ui_select"):
		release = true
	if release:
		if not is_on_floor():
			velocity.y += gravity * delta
		else:
			active = false
			touched_floor.emit()
	else:
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		

	move_and_slide()




func _on_area_2d_2_area_entered(area):
	print("a")
	pass # Replace with function body.
