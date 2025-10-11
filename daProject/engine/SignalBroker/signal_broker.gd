class_name SignalBroker extends Node

var signalRegistry: Dictionary = {}
var functionRegistry: Dictionary = {}
# Lists of functions in [functionName, emitter]

#region Registering and Requesting
func register_signal(emitter: Node, signal_name: String):
	if signal_name not in signalRegistry:
		signalRegistry[signal_name] = emitter
	# registers the emitter under the key of its signal

func get_signal_emitter(signal_name: String) -> Node:
	if signalRegistry.has(signal_name):
		return signalRegistry.get(signal_name,null)
	return null

func register_Callable(func_name: String,emitter: Node):
	if func_name not in functionRegistry:
		functionRegistry[func_name] = emitter
	# Registers the node under the key of its function name

func get_Callable(func_name: String)-> Node:
	if functionRegistry.has(func_name):
		return functionRegistry.get(func_name,null)
	return null
