extends Component_Base

signal CompInput_direction(float, int)
signal CompInput_directionPressed
signal CompInput_directionReleased
signal CompInput_jumpPressed(float)
signal CompInput_delta(float)

var dirPressed: bool = false

func _process(delta: float) -> void:
	CompInput_delta.emit(delta)
	var _inputDir : int = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	if _inputDir != 0 && dirPressed == false:
		dirPressed = true
		CompInput_directionPressed.emit()
	elif _inputDir == 0 && dirPressed == true:
		dirPressed = false
		CompInput_directionReleased.emit()
	CompInput_direction.emit(delta, _inputDir)
	
	if Input.is_action_just_pressed("ui_accept"):
		CompInput_jumpPressed.emit(delta)
