extends HTNTask

func _pre_conditions() -> Dictionary:
	return {
		"is_tired": true,
	}


func _effects() -> Dictionary:
	return {
		"is_tired": false,
	}


func execute(delta: float, actor: Variant) -> TaskResult:
	if actor.rest(delta):
		return TaskResult.SUCCESS
	return TaskResult.PROCESSING
