extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()
	expand_to_text_length = true
	max_length = 18
	#set_horizontal_alignment(len(text))
	#set_caret_column(len(text))
	#caret_column = len(text)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
