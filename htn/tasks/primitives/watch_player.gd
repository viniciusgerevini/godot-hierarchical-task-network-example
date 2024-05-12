extends HTNTask


## This is where your task implementation lives.
func execute(_delta: float, actor: Variant) -> TaskResult:
	var npc = actor as NPC
	var player = actor.player_in_sight

	if is_instance_valid(player):
		npc.look_at(player.position, Vector3.UP, true)
		return TaskResult.PROCESSING

	return TaskResult.FAILURE
