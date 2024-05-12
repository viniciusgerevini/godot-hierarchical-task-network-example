class_name HTNTask extends HTNBaseTask

enum TaskResult {
	SUCCESS,
	FAILURE,
	PROCESSING,
}

func apply_effects(world_state: HTNWorldState) -> void:
	var effects = _effects()
	for key in effects:
		world_state.set_value(key, effects[key])


func is_available(world_state:HTNWorldState) -> bool:
	var conditions = _pre_conditions()
	for key in conditions:
		if world_state.get_value(key) != conditions[key]:
			return false
	return true


## Used by the planner to change the world state
## Effect format:
## { "effect_key": "value", "effect2_key": "value }
func _effects() -> Dictionary:
	return {}


## Used by the planer to check if task is valid
## Condition format:
## { "condition_key": "value", "condition_2_key": "value }
func _pre_conditions() -> Dictionary:
	return {}


## This is where your task implementation lives.
@warning_ignore("unused_parameter")
func execute(delta: float, actor: Variant) -> TaskResult:
	return TaskResult.SUCCESS
