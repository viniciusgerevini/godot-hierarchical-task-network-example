extends HTNCompoundTask

const SetRandomPositionAsTarget = preload("res://htn/tasks/primitives/set_random_position_as_target.gd")
const SetClosestCoinAsTarget = preload("res://htn/tasks/primitives/set_closest_coin_as_target.gd")
const GoToTargetPosition = preload("res://htn/tasks/primitives/go_to_target_position.gd")
const Idle = preload("res://htn/tasks/primitives/idle.gd")

var method_1 = {
	"pre_conditions": {
		"are_there_coins_in_world": true,
		"in_coin_collection_cooldown": false,
	},
	"tasks": [SetClosestCoinAsTarget.new(), GoToTargetPosition.new(), Idle.new(1)],
}

var method_2 = {
	"pre_conditions": {},
	"tasks": [SetRandomPositionAsTarget.new(), GoToTargetPosition.new(), Idle.new()],
}

func get_methods() -> Array:
	return [method_1, method_2]


