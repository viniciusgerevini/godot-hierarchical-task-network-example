extends HTNCompoundTask

const RunAwayFromPlayerTask = preload("res://htn/tasks/compound/run_away_from_player.gd")
const WatchPlayerTask = preload("res://htn/tasks/primitives/watch_player.gd")
const DoRandomIdleActionsTask = preload("res://htn/tasks/compound/do_random_idle_actions.gd")
const Rest = preload("res://htn/tasks/primitives/rest.gd")

var method_1 = {
	"pre_conditions": {
		"is_tired": true,
	},
	"tasks": [Rest.new()],
}

var method_2 = {
	"pre_conditions": {
		"is_scared": true,
	},
	"tasks": [RunAwayFromPlayerTask.new()],
}

var method_3 = {
	"pre_conditions": {
		"is_player_nearby": true,
	},
	"tasks": [WatchPlayerTask.new()],
}

var method_4 = {
	"pre_conditions": {},
	"tasks": [DoRandomIdleActionsTask.new()],
}

func get_methods() -> Array:
	return [ method_1, method_2, method_3, method_4 ]
