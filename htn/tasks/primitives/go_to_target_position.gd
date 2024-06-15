extends HTNTask

func _pre_conditions() -> Dictionary:
	return {
		"has_target": true,
	}


func _effects() -> Dictionary:
	return {
		"has_target": false,
	}


func execute(delta, actor: Variant) -> TaskResult:
	var target = actor.get_target()

	if target == null:
		return TaskResult.FAILURE

	var target_position = target if target is Vector3 else target.position

	actor.move_towards_target(delta, target_position)

	if actor.position.distance_to(target_position) <= 1:
		actor.set_target(null)
		return TaskResult.SUCCESS

	return TaskResult.PROCESSING

