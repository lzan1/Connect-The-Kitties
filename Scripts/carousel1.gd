extends Control
var pointer = load("res://Assets/Pictures/pointinghand_100160.png")
var type_names := ['BENGAL CAT', 'PERSIAN CAT', 'SERBIAN CAT']
var type_display := [preload("res://Assets/Pictures/img1cat.png"), preload("res://Assets/Pictures/img2cat.png"), preload("res://Assets/Pictures/img3cat.png")]
var curr_index = 0
@onready var displayed_cat = $DisplayedCat
@onready var displayed_name = $Control/DisplayedName

# Called when the node enters the scene tree for the first time.
func _ready():
	displayed_name.text = type_names[curr_index]
	displayed_cat.texture = type_display[curr_index]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_mouse_entered():
	Input.set_custom_mouse_cursor(pointer,Input.CURSOR_ARROW)


func _on_button_mouse_exited():
	Input.set_custom_mouse_cursor(null)


func _on_button_pressed_lef():
	if curr_index==0:
		curr_index = len(type_names)-1
	else:
		curr_index -=1
	displayed_name.text = type_names[curr_index]
	displayed_cat.texture = type_display[curr_index]


func _on_button_pressed_right():
	if curr_index==len(type_names)-1:
		curr_index = 0
	else:
		curr_index +=1
	displayed_name.text = type_names[curr_index]
	displayed_cat.texture = type_display[curr_index]

