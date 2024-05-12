# meta-default: true
extends HTNCompoundTask

## Return an array of methods.
## method format example:
## {
##     "pre_conditions": {
##         "is_player_nearby": true,
##     },
##     "tasks": [WatchPlayerTask.new()],
## }
func get_methods() -> Array:
	return []
