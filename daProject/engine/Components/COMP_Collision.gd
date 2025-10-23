extends Component_Base

signal CompColl_touchedFloor()
signal CompColl_touchedFloorVector(Vector2)
signal CompColl_leftFloor

signal CompColl_touchedWall
signal CompColl_touchedWallVector(Vector2)
signal CompColl_leftWall

signal CompColl_touchedCeiling
signal CompColl_touchedCeilingVector(Vector2)
signal CompColl_leftCeiling

var entityIsOnFloor: bool = false
var entityIsOnWall: bool = false
var entityIsOnCeiling: bool = false

func _process(_delta: float) -> void:
	if entityIsOnFloor == false && entityParent.is_on_floor():
		entityIsOnFloor = true
		CompColl_touchedFloor.emit()
		CompColl_touchedFloorVector.emit(Vector2(0,0))
	elif entityIsOnFloor == true && entityParent.is_on_floor() == false:
		entityIsOnFloor = false
		CompColl_leftFloor.emit()
	
	if entityIsOnWall == false && entityParent.is_on_wall():
		entityIsOnWall = true
		CompColl_touchedWall.emit()
		CompColl_touchedWallVector.emit(Vector2(0,0))
	elif entityIsOnWall == true && entityParent.is_on_wall() == false:
		entityIsOnWall = false
		CompColl_leftWall.emit()
	
	if entityIsOnCeiling == false && entityParent.is_on_ceiling():
		entityIsOnCeiling = true
		CompColl_touchedCeiling.emit()
		CompColl_touchedCeilingVector.emit(Vector2(0,0))
	elif entityIsOnCeiling == true && entityParent.is_on_ceiling() == false:
		entityIsOnCeiling = false
		CompColl_leftCeiling.emit()

func CompColl_SetColl(i: int, b:bool):
	if i < 0: i = 0
	if i > 2: i = 2
	match i:
		0:entityIsOnFloor = b
		1:entityIsOnWall = b
		2:entityIsOnCeiling = b

func CompColl_GetColl(i:int) -> bool:
	if i < 0: i = 0
	if i > 2: i = 2
	match i:
		0:return entityIsOnFloor
		1:return entityIsOnWall
		2:return entityIsOnCeiling
	printerr("how? ",i)
	return false
