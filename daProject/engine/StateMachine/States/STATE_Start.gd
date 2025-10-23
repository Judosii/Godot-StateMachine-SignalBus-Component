extends StateBase

@export var idleState: StateBase
@export var r : RayCast2D

func ActivateState():
	super.ActivateState()
	while r.is_colliding() == false:
		entityParent.position += r.target_position
	var p: float = r.get_collision_point().y
	var playerHeight: float = entityParent.get_node("CollisionShape2D").shape.size.y
	entityParent.position.y = p - playerHeight/2
	# collision components, set onFloor to true
	stateManager._changeState(idleState)


func StateFunction(_delta:float):
	#super.ActivateState()
	if Input.is_action_just_pressed("ui_accept"):
		if r.is_colliding() == false:
			entityParent.position += r.target_position
			print("moving player down...")
		else:
			print(r.get_collider())
			var p :float = r.get_collision_point().y
			var playerHeight: float = entityParent.get_node("CollisionShape2D").shape.size.y
			entityParent.position.y = p - playerHeight/2
			# collision components, set onFloor to true
			stateManager._changeState(idleState)
