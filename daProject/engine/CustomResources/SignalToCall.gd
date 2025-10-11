class_name SignalToCall extends Resource

@export var signalName: String
@export var functionToCall: String
var functionHolder: Node # can't export that :[
var functionAsCall: Callable
@export var funcInState: bool = false

func GetFunctionHolder(_sb: SignalBroker): #Call when activating state to refresh
	functionHolder = _sb.get_Callable(functionToCall)
	functionAsCall = Callable(functionHolder, functionToCall)
