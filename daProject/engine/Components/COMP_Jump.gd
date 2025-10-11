extends Component_Base

signal CompJump_justJumped
signal CompJump_ReachedJumpApex

@export var timeToApex: float
@export var timeAtApex: float
@export var timeToFall: float

@export_group("timers")
@export var risingTimer: Timer
@export var apexTimer: Timer
@export var fallTimer: Timer

@export var bufferTimer: Timer
@export var coyoteTimer: Timer
@export var JUMP_VELOCITY:float
var onFloor: bool

func _ready():
	super._ready()
	risingTimer.wait_time = timeToApex
	apexTimer.wait_time = timeToApex
	fallTimer.wait_time = timeToApex

func CompJump_StartJump(_delta:float):
	if onFloor:
		print("entity jumped")
		entityParent.velocity.y = JUMP_VELOCITY
		CompJump_justJumped.emit()

func CompJump_RequestJump(_delta:float):
	pass

func CompJump_EntityLanded(_floorNormal: Vector2 = Vector2(0,0)):
	onFloor = true

func CompJump_EntityLeftFloor():
	onFloor = false
	print("entity left floor")
