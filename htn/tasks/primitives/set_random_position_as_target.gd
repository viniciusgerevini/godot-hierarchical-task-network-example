extends HTNTask


func _effects() -> Dictionary:
	return {
		"has_target": true,
	}

func execute(_delta, actor: Variant) -> TaskResult:
	print("Set random target")
	var max_distance = 3
	var current_position = actor.position
	var target_position = Vector3(
		randf_range(current_position.x - max_distance, current_position.x + max_distance),
		current_position.y,
		randf_range(current_position.z - max_distance, current_position.z + max_distance),
	)
	actor.set_target(target_position)
	return TaskResult.SUCCESS

