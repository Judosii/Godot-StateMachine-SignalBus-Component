class_name Component_Base extends Node

@onready var entityParent : Entity = $"../.."
@export var signalBroker : SignalBroker
@export var brokerBridge: SignalBrokerBridge
@export_group("signals to register")
@export var signalsToRegister: Array[String]
@export_group("functions to register")
@export var functionsToRegister: Array[String]
@export_group("")

func _ready():
	RegisterSignals()
	RegisterFunctions()

func RegisterSignals():
	for i in signalsToRegister.size():
		signalBroker.register_signal(self, signalsToRegister[i])

func RegisterFunctions():
	for i in functionsToRegister.size():
		signalBroker.register_Callable(functionsToRegister[i], self)
