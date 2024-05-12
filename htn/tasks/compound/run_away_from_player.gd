extends HTNCompoundTask

const AvoidPlayer = preload("res://htn/tasks/primitives/avoid_player.gd")
const Relax = preload("res://htn/tasks/primitives/relax.gd")
const PlayJumpScare = preload("res://htn/tasks/primitives/play_jump_scare.gd")

var method_1 = {
	"pre_conditions": {
		"is_scared": true,
	},
	"tasks": [PlayJumpScare.new(), AvoidPlayer.new(), Relax.new()],
}


func get_methods() -> Array:
	return [method_1]
