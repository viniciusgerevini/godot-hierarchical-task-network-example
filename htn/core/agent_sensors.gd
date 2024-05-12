class_name HTNAgentSensors extends Node

@export
var _actor: Node
@export
var _planner: HTNPlanner

func _ready():
	_initialize(_actor)


func set_state(state_key: String, value: Variant, notify_changes: bool = true) -> void:
	_planner.get_world_state().set_value(state_key, value, notify_changes)


## This method is called on startup so you can do any initial setup, like
## listening to signals and setting initial world state
func _initialize(actor: Node) -> void:
	pass
