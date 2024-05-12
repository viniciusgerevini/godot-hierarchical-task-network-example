extends Area3D

signal collected

var time := 0.0
var grabbed := false

func _on_body_entered(body):
	if body.has_method("collect_coin") and !grabbed:

		body.collect_coin()

		Audio.play("res://sounds/coin.ogg") # Play sound

		$Mesh.queue_free() # Make invisible
		$Particles.emitting = false # Stop emitting stars

		grabbed = true

		self.remove_from_group("coin")
		collected.emit()
		#await get_tree().create_timer(3).timeout
		self.queue_free()


func _process(delta):

	rotate_y(2 * delta) # Rotation
	position.y += (cos(time * 5) * 1) * delta # Sine movement

	time += delta
