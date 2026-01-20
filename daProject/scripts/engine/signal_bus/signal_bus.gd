@tool @icon("res://assets/ICON_SignalBroker.svg")
extends Node
class_name Signal_Bus

#region window
var window: Window
var curParent: Node
@export_tool_button("open signal bus window")
var button = OnOpenWindow
var allNodesArray : Array[Node]
@export var windowHierarchy: PackedScene


func OnOpenWindow():
#region WindowSetup
	if window != null:
		return
	allNodesArray.clear()
	window = Window.new()
	var windTitle: String = get_parent().name + "'s broker window"
	window.title = windTitle
	EditorInterface.popup_dialog(window,Rect2(Vector2(100,100), Vector2(640,360)))
	window.close_requested.connect(_on_close_requested)
#endregion

	var _h: SignalBus_WindowHierarchy = windowHierarchy.instantiate()
	window.add_child(_h)
	# Top of the edited scene tree
	var sceneRoot: Node = EditorInterface.get_edited_scene_root()
	# All children of edited tree get detected
	LoopForAllNodeChildren(sceneRoot)
	
	for i in allNodesArray.size():
		_h.GetNodeList().add_child(_h.MakeNewNodeEntry(allNodesArray[i]))
		var hSep := HSeparator.new()
		_h.GetNodeList().add_child(hSep)

#Get all nodes in edited scene tree
func LoopForAllNodeChildren(_n:Node) -> Array[Node]:
	allNodesArray.append(_n)
	var _a: Array[Node]
	for i in _n.get_children().size():
		LoopForAllNodeChildren(_n.get_child(i))
	return _a

func _on_close_requested():
	window.queue_free()
#endregion

# v don't touch this until you've made everything visual work
#region registries
@export var signalRegistry: Dictionary = {}
@export var functionRegistry: Dictionary = {}
# Lists of functions in [functionName, emitter]

func register_signal(emitter: Node, signal_name: String):
	if signal_name not in signalRegistry:
		signalRegistry[signal_name] = emitter
	# registers the emitter under the key of its signal

func get_signal_emitter(signal_name: String) -> Node:
	if signalRegistry.has(signal_name):
		return signalRegistry.get(signal_name,null)
	return null

func delete_signal(signal_name: String) -> bool:
	return signalRegistry.erase(signal_name)

func register_Callable(func_name: String,emitter: Node):
	if func_name not in functionRegistry:
		functionRegistry[func_name] = emitter
	# Registers the node under the key of its function name

func get_Callable(func_name: String)-> Node:
	if functionRegistry.has(func_name):
		return functionRegistry.get(func_name,null)
	return null

func delete_Callable(func_name: String) -> bool:
	return functionRegistry.erase(func_name)
	#endregion
