class_name HTNWorldState extends RefCounted

signal state_changed

var _state = {}

func _init(state: Dictionary = {}):
	_state = state


func set_value(state_key: String, value: Variant, notify_state_change: bool = true) -> void:
	if _state.get(state_key) == value:
		return
	_state[state_key] = value

	if notify_state_change:
		state_changed.emit()


func get_value(state_key: String, default_value: Variant = null) -> Variant:
	return _state.get(state_key, default_value)


func duplicate() -> HTNWorldState:
	return HTNWorldState.new(_state.duplicate())
