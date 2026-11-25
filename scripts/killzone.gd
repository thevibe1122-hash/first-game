extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("your dead")
	Engine.time_scale = 0.5
	
	# Stop the player from moving and tell them they are dead
	if body.has_method("die"):
		body.die()
	
	# Wait for the death animation to finish before reloading
	# (Make sure your Timer wait time is set to e.g., 1.5 seconds in the Inspector)
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
