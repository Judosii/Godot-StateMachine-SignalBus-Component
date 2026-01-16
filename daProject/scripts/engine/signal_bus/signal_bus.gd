@tool @icon("res://assets/ICON_SignalBroker.svg")
extends Node
class_name Signal_Bus

#region window
var window: Window
var curParent: Node
@export_tool_button("open signal bus window")
var button = OnOpenWindow
var allNodesArray : Array[Node]


func OnOpenWindow():
	allNodesArray.clear()
	if window != null:
		return
	window = Window.new()
	var windTitle: String = get_parent().name + "'s broker window"
	window.title = windTitle
	EditorInterface.popup_dialog(window,Rect2(Vector2(100,100), Vector2(640,360)))
	window.close_requested.connect(_on_close_requested)
	#Window Setup done
	
	var sceneRoot: Node = EditorInterface.get_edited_scene_root()
	LoopForAllChildren(sceneRoot)
	var vbox:= VBoxContainer.new()
	window.add_child(vbox)
	for i in allNodesArray.size():
		print(allNodesArray[i])
		var label:= Label.new()
		vbox.add_child(label)
		label.text = allNodesArray[i].name

func LoopForAllChildren(_n:Node) -> Array[Node]:
	allNodesArray.append(_n)
	var _a: Array[Node]
	for i in _n.get_children().size():
		LoopForAllChildren(_n.get_child(i))
	return _a

func _on_close_requested():
	window.queue_free()
#endregion

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
