class_name NPCSensors extends HTNAgentSensors


## This method is called on startup so you can do any initial setup, like
## listening to signals and setting initial world state
func _initialize(actor: Node):
	var npc = actor as NPC

	npc.target_changed.connect(_on_target_changed)
	npc.player_moved_nearby.connect(_on_player_nearby)
	npc.player_moved_far.connect(_on_player_far)
	npc.scared.connect(_on_scared)
	npc.relaxed.connect(_on_relaxed)
	npc.tired.connect(_on_tired)
	npc.rested.connect(_on_rested)
	npc.coin_collection_enabled.connect(_leave_coin_collection_cooldown)
	npc.coin_collection_disabled.connect(_start_coin_collection_cooldown)

	Events.coin_collected.connect(_check_coins)
	Events.coin_spawned.connect(_check_coins)

	set_state("has_target", false, false)
	set_state("is_player_nearby", false, false)
	set_state("are_there_coins_in_world", actor.get_tree().get_nodes_in_group("coin").size() > 0)
	set_state("in_coin_collection_cooldown", false, false)


# not notifying changes on target change because this is only caused by plan changes
func _on_target_changed(target: Variant):
	if is_instance_valid(target) or target is Vector3:
		set_state("has_target", true, false)
	else:
		set_state("has_target", false, false)


func _on_player_nearby():
	set_state("is_player_nearby", true)


func _on_player_far():
	set_state("is_player_nearby", false)


func _on_scared():
	set_state("is_scared", true)


func _on_relaxed():
	set_state("is_scared", false)


func _on_tired():
	set_state("is_tired", true)


func _on_rested():
	set_state("is_tired", false)


func _check_coins():
	set_state("are_there_coins_in_world", self.get_tree().get_nodes_in_group("coin").size() > 0)


func _start_coin_collection_cooldown():
	set_state("in_coin_collection_cooldown", true, false)


func _leave_coin_collection_cooldown():
	set_state("in_coin_collection_cooldown", false)
