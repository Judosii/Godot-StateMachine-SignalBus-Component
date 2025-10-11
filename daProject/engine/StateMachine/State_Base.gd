class_name StateBase extends Node

@export_group("state variables")
@export var canBeHurt: bool
@export var canJump: bool
@export var applyGravity: bool

@onready var stateManager : StateMachine = $".."
@onready var signalBroker : SignalBroker = stateManager.signalBroker
@onready var entityParent : CharacterBody2D = $"../.."

@export_category("Signal to function")
@export var signalsToListen : Array[SignalToCall]

@export_category("Signal to state")
@export var signalsToState : Array[SignalToCall]

func ActivateState():
	print("")
	print("activating state: ", name)
	ConnectToSignals()
	if canBeHurt:
		pass
	if canJump:
		pass
	if applyGravity:
		pass

func DeactivateState():
	print("deactivating state: ", name)
	DisconnectFromSignals()

func ConnectToSignals():
	#Start listening to signals
	for i in signalsToListen.size():
		signalsToListen[i].GetFunctionHolder(signalBroker)
		var emitter: Node= signalBroker.get_signal_emitter(signalsToListen[i].signalName)
		#Get the actual function holder to do it directly
		var functionHolder = self
		if signalsToListen[i].funcInState == false:
			functionHolder = signalsToListen[i].functionHolder
		#Make a callable out of function holder, and the function name
		var newcall = Callable(functionHolder, signalsToListen[i].functionToCall)
		emitter.connect(signalsToListen[i].signalName, newcall)
		#print( "connecting signal [", signalsToListen[i].signalName,"] to function ",signalsToListen[i].functionToCall, "()")
	
	for i in signalsToState.size():
		var _emitter: Node= signalBroker.get_signal_emitter(signalsToState[i].signalName)
		var newCall = Callable(stateManager, "_changeState").bind(stateManager.get_node(signalsToState[i].functionToCall))
		_emitter.connect(signalsToState[i].signalName, newCall)

func DisconnectFromSignals():
	#Stop listening to signals
	for i in signalsToListen.size():
		var emitter: Node= signalBroker.get_signal_emitter(signalsToListen[i].signalName)
		var functionHolder = self
		if signalsToListen[i].funcInState == false:
			functionHolder = signalsToListen[i].functionHolder
		var newcall = Callable(functionHolder, signalsToListen[i].functionToCall)
		emitter.disconnect(signalsToListen[i].signalName, newcall)
		#print("disconnecting signal [", signalsToListen[i].signalName, "] to function", signalsToListen[i].functionToCall,"()")
	
	for i in signalsToState.size():
		var _emitter: Node= signalBroker.get_signal_emitter(signalsToState[i].signalName)
		var newCall = Callable(stateManager, "_changeState")
		_emitter.disconnect(signalsToState[i].signalName, newCall)

func StateFunction(_delta:float):
	pass
	#Main Behaviour of the state
