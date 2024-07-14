extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	self.release_focus()
	expand_to_text_length = true
	max_length = 18
