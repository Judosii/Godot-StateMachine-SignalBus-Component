extends Resource
class_name SignalBrokerBridge

var broker : SignalBroker

@export var b: Callable

### TODO WRITING

## BASE PICKER MENU
#Show every function and signal of attached node
#Loop through all of them, doing signalBroker.get_x
#If null, then it has not been connected yet
#Else, it has been connected
#Organise by node alphabetically with drop down menu as such: 
#O-node...v
#O-node...^
#|-signal name
#|-function name

## REGISTERING SIGNALS AND FUNCTIONS
#Have a checkmark next to every signal / function
#Clicking it connects/ unconnects to the broker
#Organise by signal alphabetically, then by function alphabetically

## CONNECTING SIGNALS TO FUNCTIONS
#Should have a slightly different menu, where you can choose a signal then a function
#Prioritise showing the node's functions first

func RegisterBroker():
	pass
