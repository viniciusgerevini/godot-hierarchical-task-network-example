class_name HTNPlanner extends Node

const PlanRunner = preload("res://htn/core/plan_runner.gd")

@export
var _actor: Node

@export
var _domain: Script

var _world_state := HTNWorldState.new()
var _root
var _state_stack: Array[HTNWorldState] = []
var _plan_runner

func _ready():
	_setup_world_state()
	_setup_domain()
	_setup_plan_runner()
	_plan()


func _setup_world_state():
	_world_state.state_changed.connect(_on_world_state_changed)


func _setup_domain():
	if _domain == null:
		push_error("Domain was not defined")
		return
	_root = _domain.new()


func _setup_plan_runner():
	if _actor == null:
		push_error("Actor not defined")
		return

	_plan_runner = PlanRunner.new(_world_state, _actor)
	_plan_runner.plan_finished.connect(_on_plan_execution_finished)
	add_child(_plan_runner)


func _plan():
	_initialize_working_state()
	var plan = _decompose_compound_task(_root)
	if plan.size() > 0:
		print("New plan")
		print(plan.map(func(task): return task.get_script().get_path()))
		_plan_runner.set_plan(plan)
	_clear_working_state()


func _decompose_compound_task(task: HTNCompoundTask) -> Array[HTNTask]:
	var methods = task.get_methods()
	var current_state = _current_working_state()

	for method in methods:
		if _check_conditions(method.pre_conditions, current_state):
			_save_current_working_state()
			var decomposed_tasks = _decompose_tasks(method.tasks)
			if decomposed_tasks.size() == 0:
				_restore_previous_state()
				continue
			return decomposed_tasks

	return []


func _decompose_tasks(tasks: Array) -> Array[HTNTask]:
	var decomposed_tasks: Array[HTNTask] = []
	var current_state = _current_working_state()

	for child_task in tasks:
		if child_task is HTNCompoundTask:
			var t = _decompose_compound_task(child_task)
			if t.size() == 0:
				return []
			decomposed_tasks.append_array(t)
		elif child_task.is_available(current_state):
			child_task.apply_effects(current_state)
			decomposed_tasks.push_back(child_task)
		else:
			return []

	return decomposed_tasks


func _on_world_state_changed():
	print("World state changed. Re-planning.")
	_plan()


func _on_plan_execution_finished():
	print("Plan finished. Re-planning.")
	_plan()


func _check_conditions(conditions: Dictionary, world_state: HTNWorldState) -> bool:
	for key in conditions:
		if world_state.get_value(key) != conditions[key]:
			return false
	return true


func get_world_state() -> HTNWorldState:
	return _world_state


func _current_working_state() -> HTNWorldState:
	return _state_stack[_state_stack.size() - 1]


func _initialize_working_state():
	_state_stack = [_world_state.duplicate()]


func _save_current_working_state():
	_state_stack.push_back(_current_working_state().duplicate())


func _restore_previous_state():
	_state_stack.pop_back()


func _clear_working_state():
	_state_stack = []
