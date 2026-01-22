@tool
extends Control
class_name SignalBus_WindowHierarchy

@export var nodeList: VBoxContainer
@export var buttonHoverSize: Vector2
@export var buttonPressSize: Vector2

var nodeInListSelected: Button

func _ready() -> void:
	print("signal bus window hierarchy instanced!")

func GetNodeList()-> VBoxContainer: #WARNING, child 0 will always be title
	return nodeList

func MakeNewNodeEntry(_n: Node) -> Control:
	var _button:= Button.new()
	
	var _cEnter:= Callable(self, "ButtonMouseEntered").bind(_button)
	_button.mouse_entered.connect(_cEnter)
	var _cExit:= Callable(self, "ButtonMouseExited").bind(_button)
	_button.mouse_exited.connect(_cExit)
	var _cPress:= Callable(self, "ButtonMousePressed").bind(_button)
	_button.pressed.connect(_cPress)
	
	_button.icon = EditorInterface.get_editor_theme().get_icon(_n.get_class(), &"EditorIcons")
	_button.expand_icon = true
	_button.text = _n.name
	_button.connect("pressed", Callable(self, "NewNodeSelected"))
	var _cInit := Callable(self, "InitializeButton").bind(_button)
	_cInit.call_deferred()
	return _button

#region NodeEntry Button Stuff
func InitializeButton(_b:Button):
	_b.pivot_offset = _b.size/2.0

func ButtonMouseEntered(_b:Button):
	create_tween().tween_property(_b,"scale",buttonHoverSize,0.1).set_trans(Tween.TRANS_SINE)

func ButtonMouseExited(_b:Button):
	create_tween().tween_property(_b,"scale",Vector2.ONE,0.1).set_trans(Tween.TRANS_SINE)

func ButtonMousePressed(_b:Button):
	create_tween().tween_property(_b,"scale",buttonPressSize,0.06).set_trans(Tween.TRANS_SINE)
	create_tween().tween_property(_b,"scale", buttonHoverSize, 0.2).set_trans(Tween.TRANS_SINE)
#endregion

func NewNodeSelected():
	print("a")
