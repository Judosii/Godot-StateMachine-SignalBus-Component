extends Component_Base

@export var maxSpeed :float = 450.0
signal CompMove_startMoving
signal CompMove_stopMoving

var characterIsMoving: bool = false

func CompMove_Move(_delta, direction):
	if direction:
		#velocity.x = direction * SPEED
		entityParent.velocity.x = move_toward(entityParent.velocity.x, direction*maxSpeed, maxSpeed/4)
		if characterIsMoving == false && entityParent.velocity.x != 0:
			characterIsMoving = true
			CompMove_startMoving.emit()
	else:
		entityParent.velocity.x = move_toward(entityParent.velocity.x, 0, maxSpeed/4)
	if characterIsMoving == true && entityParent.velocity.x == 0:
		characterIsMoving = false
		CompMove_stopMoving.emit()
