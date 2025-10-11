class_name Entity extends CharacterBody2D
@export var debugLabel: Label
@export var stateMachine: StateMachine

func _physics_process(_delta: float) -> void:
	stateMachine.UseState(_delta)
	move_and_slide()
