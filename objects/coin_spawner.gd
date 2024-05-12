extends Node3D

const Coin = preload("res://objects/coin.tscn")

const MAX_DISTANCE = 10

func _on_timer_timeout():
	if self.get_tree().get_nodes_in_group("coin").size() < 5:
		_spawn_coin()


func _spawn_coin():
	var coin = Coin.instantiate()
	self.get_parent().add_child(coin)
	coin.position = _get_random_position()
	coin.collected.connect(_on_coin_collected)
	Events.coin_spawned.emit()


func _get_random_position() -> Vector3:
	var spawn_position = self.position

	return Vector3(
		randf_range(spawn_position.x - MAX_DISTANCE, spawn_position.x + MAX_DISTANCE),
		spawn_position.y,
		randf_range(spawn_position.z - MAX_DISTANCE, spawn_position.z + MAX_DISTANCE),
	)


func _on_coin_collected():
	print("coin collected")
	Events.coin_collected.emit()
