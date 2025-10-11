class_name StateMachine extends Node

@export_category("Signal Broker")
@export var signalBroker : SignalBroker

@export_category("")
@export var curState: StateBase
@export var animationPlayer: AnimationPlayer

func UseState(delta:float):
	curState.StateFunction(delta)

func _ready() -> void:
	curState.ActivateState()
	var entity :Entity = get_parent()
	entity.debugLabel.text = curState.name

func _changeState(newState: StateBase):
	var entity :Entity = get_parent()
	curState.DeactivateState()
	newState.ActivateState()
	curState= newState
	entity.debugLabel.text = curState.name
