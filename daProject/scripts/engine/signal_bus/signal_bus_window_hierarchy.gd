@tool
extends Control
class_name SignalBus_WindowHierarchy

@export var nodeList: VBoxContainer

func _ready() -> void:
	print("signal bus window hierarchy instanced!")

func GetNodeList()-> VBoxContainer: #WARNING, child 0 will always be title
	return nodeList

func MakeNewNodeEntry(_n: Node) -> HBoxContainer:
	var _entryParent:= HBoxContainer.new()
	var _entryIcon:= TextureRect.new()
	var _entryName:= Label.new()
	
	_entryParent.add_child(_entryIcon)
	_entryParent.add_child(_entryName)
	_entryName.text = _n.name
	_entryIcon.texture = EditorInterface.get_editor_theme().get_icon(_n.get_class(), &"EditorIcons")
	_entryIcon.stretch_mode = TextureRect.STRETCH_KEEP
	
	return _entryParent
