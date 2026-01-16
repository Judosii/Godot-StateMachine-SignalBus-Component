@icon("res://assets/componentIcon.svg")
extends Component_Base

signal dirInput(float, int)
signal jumpPressed(float)

func _process(_delta: float) -> void:
	
	var inputDir: int = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	dirInput.emit(_delta, inputDir)
	
	if Input.is_action_just_pressed("ui_accept"):
		jumpPressed.emit(_delta)
