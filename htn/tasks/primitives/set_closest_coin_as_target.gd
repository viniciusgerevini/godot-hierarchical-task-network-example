extends HTNTask


func _pre_conditions() -> Dictionary:
	return {
		"are_there_coins_in_world": true,
		"in_coin_collection_cooldown": false,
	}


func _effects() -> Dictionary:
	return {
		"has_target": true,
	}


func execute(_delta, actor: Variant) -> TaskResult:
	print("lookin for coins")
	var coins = actor.get_tree().get_nodes_in_group("coin")
	var closest_distance = 9999999
	var closest_coin = null

	for coin in coins:
		var coin_distance = actor.position.distance_to(coin.position)
		print("coin distance %s" % coin_distance)
		if coin_distance <= closest_distance:
			closest_coin = coin
			closest_distance = coin_distance

	if closest_coin == null:
		print("no coin")
		return TaskResult.FAILURE

	print("Position: %s" % closest_coin.position)
	actor.set_target(closest_coin)
	print("coin")
	return TaskResult.SUCCESS

