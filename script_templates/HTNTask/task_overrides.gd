# meta-default: true
extends HTNTask

## Used by the planer to check if task is valid
## Condition format:
## { "condition_key": "value", "condition_2_key": "value }
func _pre_conditions() -> Dictionary:
	return {}


## Used by the planner to change the world state
## Effect format:
## { "effect_key": "value", "effect2_key": "value }
func _effects() -> Dictionary:
	return {}


## This is where your task implementation lives.
func execute(delta: float, actor: Variant) -> TaskResult:
	return TaskResult.SUCCESS
