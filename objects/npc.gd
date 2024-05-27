class_name NPC extends CharacterBody3D

@export_subgroup("Components")
@export var view: Node3D

@export_subgroup("Properties")
@export var movement_speed = 250
@export var jump_strength = 7

var movement_velocity: Vector3
var rotation_direction: float
var gravity = 0

var previously_floored = false

var jump_single = true
var jump_double = true

var coins = 0

@onready var particles_trail = $ParticlesTrail
@onready var sound_footsteps = $SoundFootsteps
@onready var model = $Character
@onready var animation = $Character/AnimationPlayer

# These props were added for the HTN example
signal target_changed(target: Variant)
signal player_moved_nearby
signal player_moved_far
signal scared
signal relaxed
signal tired
signal rested
signal coin_collection_enabled
signal coin_collection_disabled

var _target
var player_in_sight
var is_idling = false
var idle_time = 0
var scares = 0
var tired_recover_left = 0
var coin_collection_cooldown


func _physics_process(delta):
	handle_gravity(delta)
	handle_effects()

	# Movement

	var applied_velocity: Vector3

	applied_velocity = velocity.lerp(movement_velocity, delta * 10)
	applied_velocity.y = -gravity

	velocity = applied_velocity
	move_and_slide()
	movement_velocity = Vector3.ZERO

	# Rotation

	if Vector2(velocity.z, velocity.x).length() > 0:
		rotation_direction = Vector2(velocity.z, velocity.x).angle()

	rotation.y = lerp_angle(rotation.y, rotation_direction, delta * 10)


	# Animation for scale (jumping and landing)

	model.scale = model.scale.lerp(Vector3(1, 1, 1), delta * 10)

	# Animation when landing

	if is_on_floor() and gravity > 2 and !previously_floored:
		model.scale = Vector3(1.25, 0.75, 1.25)
		Audio.play("res://sounds/land.ogg")

	previously_floored = is_on_floor()

# Handle animation(s)

func handle_effects():
	particles_trail.emitting = false
	sound_footsteps.stream_paused = true

	if is_on_floor():
		if abs(velocity.x) > 1 or abs(velocity.z) > 1:
			animation.play("walk", 0.5)
			particles_trail.emitting = true
			sound_footsteps.stream_paused = false
		else:
			animation.play("idle", 0.5)
	else:
		animation.play("jump", 0.5)


func handle_gravity(delta):

	gravity += 25 * delta

	if gravity > 0 and is_on_floor():

		jump_single = true
		gravity = 0


func jump():
	gravity = -jump_strength

	model.scale = Vector3(0.5, 1.5, 0.5)

	jump_single = false;
	jump_double = true;


func set_target(target: Variant):
	_target = target
	target_changed.emit(_target)


func get_target():
	return _target


func _on_player_detection_sensor_body_entered(body):
	player_in_sight = body
	player_in_sight.jumped.connect(_on_player_jumped)


func _on_player_detection_sensor_body_exited(_body):
	player_in_sight.jumped.disconnect(_on_player_jumped)
	player_in_sight = null


func move_towards_target(delta: float, target: Vector3):
	var target_direction = self.position.direction_to(target)
	target_direction.y = 0

	target_direction = target_direction.normalized()

	movement_velocity = target_direction * movement_speed * delta


func _on_player_jumped():
	if self.position.distance_to(player_in_sight.position) < 3:
		scared.emit()
		scares += 1


func relax():
	relaxed.emit()
	if scares > 2:
		scares = 0
		tired.emit()


func rest(delta: float):
	$RestParticle.emitting = true
	tired_recover_left += delta
	if tired_recover_left >= 10:
		tired_recover_left = 0
		$RestParticle.emitting = false
		rested.emit()
		return true
	return false


func _on_close_range_sensor_body_entered(_body):
	player_moved_nearby.emit()


func _on_close_range_sensor_body_exited(_body):
	player_moved_far.emit()


func collect_coin():
	coins += 1
	coin_collection_disabled.emit()
	await get_tree().create_timer(randf_range(3, 10)).timeout
	coin_collection_enabled.emit()

