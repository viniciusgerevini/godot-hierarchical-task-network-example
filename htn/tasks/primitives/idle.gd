extends HTNTask

var MIN_IDLE_TIME = 0.0
var MAX_IDLE_TIME = 3.0

func _init(min_idle_time: float = 0.0, max_idle_time: float = 3.0):
	MIN_IDLE_TIME = min_idle_time
	MAX_IDLE_TIME = max_idle_time


## This is where your task implementation lives.
func execute(delta: float, actor: Variant) -> TaskResult:
	if not actor.is_idling:
		actor.idle_time = randf_range(MIN_IDLE_TIME, MAX_IDLE_TIME)
		actor.is_idling = true
		print("Entering idle for %.2f seconds" % actor.idle_time)
		return TaskResult.PROCESSING

	actor.idle_time -= delta

	if actor.idle_time <= 0:
		actor.is_idling = false
		print("Leaving idle")
		return TaskResult.SUCCESS

	return TaskResult.PROCESSING

