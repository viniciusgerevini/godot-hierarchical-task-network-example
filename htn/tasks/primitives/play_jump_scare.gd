extends HTNTask

func _pre_conditions() -> Dictionary:
	return {
		"is_scared": true,
	}


func _effects() -> Dictionary:
	return {}


func execute(_delta: float, actor: Variant) -> TaskResult:
	actor.jump()
	return TaskResult.SUCCESS
