extends AnimatableBody2D

@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer_2: Timer = $Timer2
@onready var platform: AnimatableBody2D = $"."

func _on_entered(_body: Node2D) -> void:
	$Timer.start()
		
func Enable():
	$CollisionShape2D.set_deferred($CollisionShape2D.disabled,false)
	print("enabled")
	
func _on_timer_timeout() -> void:
	$CollisionShape2D.set_deferred($CollisionShape2D.disabled,true)
	print("disabled")
	$Timer2.start()
	
func _on_timer2_timeout() -> void:
		Enable()
	

	
