extends HTNTask


func _pre_conditions() -> Dictionary:
	return {
		"is_scared": true,
	}


func _effects() -> Dictionary:
	return {}


func execute(delta, actor: Variant) -> TaskResult:
	var npc = actor as NPC
	var player = actor.player_in_sight as CharacterBody3D

	if is_instance_valid(player):
		var run_direction = player.position.direction_to(npc.position)
		var target = run_direction * 4
		target.y = 0
		npc.move_towards_target(delta, target)
		return TaskResult.PROCESSING

	return TaskResult.SUCCESS
