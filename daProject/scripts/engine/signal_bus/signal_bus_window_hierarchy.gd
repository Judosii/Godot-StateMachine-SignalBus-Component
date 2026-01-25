@tool
extends Control
class_name SignalBus_WindowHierarchy

@export var nodeList: VBoxContainer
@export var signalList: VBoxContainer
@export var funcList: VBoxContainer
@export var buttonHoverSize: Vector2
@export var buttonPressSize: Vector2

var nodeInListSelected: Button

func _ready() -> void:
	print("signal bus window hierarchy instanced!")

func GetNodeList()-> VBoxContainer: #WARNING, child 0 will always be title
	return nodeList

func NewEntry() -> Button:
	var _butt:= Button.new()
	
	var _cEnter:= Callable(self, "ButtonMouseEntered").bind(_butt)
	_butt.mouse_entered.connect(_cEnter)
	var _cExit:= Callable(self, "ButtonMouseExited").bind(_butt)
	_butt.mouse_exited.connect(_cExit)
	var _cPress:= Callable(self, "ButtonMousePressed").bind(_butt)
	_butt.pressed.connect(_cPress)
	
	return _butt

func MakeNewNodeEntry(_n: Node) -> Control:
	var _button:= NewEntry()
	
	_button.icon = EditorInterface.get_editor_theme().get_icon(_n.get_class(), &"EditorIcons")
	_button.expand_icon = true
	_button.text = _n.name
	_button.connect("pressed", Callable(self, "NewNodeSelected").bind(_n))
	var _cInit := Callable(self, "InitializeButton").bind(_button)
	_cInit.call_deferred()
	return _button

#region Button Initialisation
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

#region Node Selected, show signals & functions
func NewNodeSelected(_n:Node):
	#instead of making a new entry for every signal...
	#replace the text on the button with the text of the node.get_signal()[i]..
	#until you run out of buttons to retext, or of signals to add to the list
	
	for i in signalList.get_child_count()-1:
		signalList.get_child(i+1).queue_free()
	for i in funcList.get_child_count()-1:
		funcList.get_child(i+1).queue_free()
	for i in _n.get_signal_list().size():
		MakeNewSignalEntry(_n.get_signal_list()[i].name)
	for i in _n.get_method_list().size():
		MakeNewFunctionEntry(_n.get_method_list()[i].name)
		#print(_n.get_signal_list()[i].name)

func MakeNewSignalEntry(_s: String):
	var _button:= NewEntry()
	_button.text = _s
	signalList.add_child(_button)

func MakeNewFunctionEntry(_s:String):
	var _button:= NewEntry()
	_button.text = _s
	funcList.add_child(_button)
#endregion

#region FilterLists
func FilterNodes(_s: String):
	if _s == "":
		for i in nodeList.get_child_count():
			nodeList.get_child(i).visible = true
		return
	FilterLogic(_s, nodeList)

func FilterSignals(_s: String):
	if _s == "":
		for i in signalList.get_child_count():
			signalList.get_child(i).visible = true
		return
	FilterLogic(_s, signalList)

func FilterMethods(_s: String):
	if _s == "":
		for i in funcList.get_child_count():
			funcList.get_child(i).visible = true
		return
	FilterLogic(_s, funcList)

func FilterLogic(_s:String, _list:VBoxContainer):
	for i in _list.get_child_count()-1:
		if _list.get_child(i+1) is Button:
			if _s not in _list.get_child(i+1).text:
				_list.get_child(i+1).visible = false
			else:
				_list.get_child(i+1).visible = true

#endregion
