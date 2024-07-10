extends Control

var pointer = load("res://Assets/Pictures/pointinghand_100160.png")
var envi_names := ['COZY KITCHEN', 'WARM BEDROOM', 'SUNNY BAKERY']
var envi_display := [preload("res://Assets/Pictures/envi_bkg1.png"), 
					preload("res://Assets/Pictures/envi_bkg2.png"), 
					preload("res://Assets/Pictures/envi_bkg3.png")]
@onready var displayed_bkg = $DisplayedBkg
@onready var background_display = $background_mask/background_display
var curr_index = 0
#==========REPRESENTATION INVARIANTS==============
#Length of envi_display and envi_names should always be the same

# Called when the node enters the scene tree for the first time.
func _ready():
	displayed_bkg.text = envi_names[curr_index]
	background_display.texture = envi_display[curr_index]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_mouse_entered():
	Input.set_custom_mouse_cursor(pointer,Input.CURSOR_ARROW)


func _on_button_mouse_exited():
	Input.set_custom_mouse_cursor(null)


func _on_right_button_pressed():
	if curr_index==len(envi_names)-1:
		curr_index = 0
	else:
		curr_index +=1
	displayed_bkg.text = envi_names[curr_index]
	background_display.texture = envi_display[curr_index]


func _on_left_button_pressed():
	if curr_index==0:
		curr_index = len(envi_names)-1
	else:
		curr_index -=1
	displayed_bkg.text = envi_names[curr_index]
	background_display.texture = envi_display[curr_index]
	
func get_curr_scene():
	return envi_display[curr_index]
