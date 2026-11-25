
extends Node2D

var is_dead = false
const speed = 60
var direction = 1

@onready var timer: Timer = $Timer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight



func _process(delta) -> void:
	if is_dead:
		return
		
	if ray_cast_right.is_colliding():
		direction = -1
		sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		sprite.flip_h = false
	position.x+= direction*speed * delta

	
func die():
	is_dead = true
	$AnimatedSprite2D.play("death")
	print("Green blob dying!")
	timer.start()
	
	# Optional: If you have a death animation, uncomment the line below
	# sprite.play("death") 
	
	# Turn off collision so it can't hit the player anymore
	$Area2D.set_deferred("monitoring", false)
	$killzone.set_deferred("monitoring", false)
	
	# Delete the blob
func _on_timer_timeout() -> void:
		queue_free()

	
# 
	
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
