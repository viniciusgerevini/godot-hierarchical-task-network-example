extends Node

signal plan_finished

var _world_state: HTNWorldState
var _tasks: Array[HTNTask] = []
var _actor: Variant


func _init(state: HTNWorldState, actor: Variant):
	_world_state = state
	_actor = actor


func set_plan(tasks: Array[HTNTask]) -> void:
	print("\n>>> New plan set. Tasks: %d" % tasks.size())
	_tasks = tasks


func _process(delta: float):
	if _tasks.size() == 0:
		return
	_execute_current_task(delta)


func _execute_current_task(delta: float) -> void:
	var current_task = _tasks[0]
	var task_result = current_task.execute(delta, _actor)

	match task_result:
		HTNTask.TaskResult.PROCESSING:
			return
		HTNTask.TaskResult.FAILURE:
			print("Task failed %s" % current_task.get_script().get_path())
			_finish_plan()
		HTNTask.TaskResult.SUCCESS:
			print("Task succeeded %s" % current_task.get_script().get_path())
			_next_task(delta)


func _next_task(delta: float) -> void:
	_tasks.pop_front()

	if _tasks.size() == 0:
		_finish_plan()
		return

	var new_task = _tasks[0]
	print(_world_state._state)
	if not new_task.is_available(_world_state):
		print("Task not available %s" % new_task.get_script().get_path())
		_finish_plan()
		return

	print("Starting task %s" % new_task.get_script().get_path())
	_execute_current_task(delta)


func _finish_plan():
	_tasks = []
	plan_finished.emit()
