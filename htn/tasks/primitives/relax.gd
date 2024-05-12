extends HTNTask

func _pre_conditions() -> Dictionary:
	return {
		"is_scared": true,
	}


func _effects() -> Dictionary:
	return {
		"is_scared": false,
	}


func execute(_delta: float, actor: Variant) -> TaskResult:
	actor.relax()
	return TaskResult.SUCCESS

