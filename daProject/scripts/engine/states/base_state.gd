@icon("res://assets/stateIcon.svg")
extends Node
class_name State_Base

@onready var entity_owner: Entity = %"../.."
@onready var signal_bus :Signal_Bus = %"../../signal_bus"

func GetSignalBusData():
	pass

func ListenToSignals():
	pass
