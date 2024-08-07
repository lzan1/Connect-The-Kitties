extends Control
var pointer = load("res://Assets/Pictures/pointinghand_100160.png")
var type_names := ['TURKISH ANGORA', 'RUSSIAN BLUE', 'BENGAL CAT', 'CALICO CAT', 'MAINE COON CAT']
var type_display := [preload("res://Assets/Pictures/img1cat.png"), 
					preload("res://Assets/Pictures/img2cat.png"), 
					preload("res://Assets/Pictures/img3cat.png"),
					preload("res://Assets/Pictures/img4cat.png"),
					preload("res://Assets/Pictures/img5cat.png")]
var curr_index = 0
@onready var displayed_cat = $DisplayedCat
@onready var displayed_name = $Control/DisplayedName
@onready var arrow_sfx = $arrow_sfx

# Called when the node enters the scene tree for the first time.
func _ready():
	displayed_name.text = type_names[curr_index]
	displayed_cat.texture = type_display[curr_index]

func _on_button_mouse_entered():
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_ARROW)


func _on_button_mouse_exited():
	Input.set_custom_mouse_cursor(null)


func _on_button_pressed_lef():
	arrow_sfx.play()
	if curr_index==0:
		curr_index = len(type_names)-1
	else:
		curr_index -=1
	displayed_name.text = type_names[curr_index]
	displayed_cat.texture = type_display[curr_index]


func _on_button_pressed_right():
	arrow_sfx.play()
	if curr_index==len(type_names)-1:
		curr_index = 0
	else:
		curr_index +=1
	displayed_name.text = type_names[curr_index]
	displayed_cat.texture = type_display[curr_index]
	
func get_p1_cat():
	return type_display[curr_index]

