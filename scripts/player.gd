extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -400.0
const DOUBLE_JUMP_VELOCITY = -450.0

var jump_count = 0
var max_jumps = 2 
var is_attacking = false 

@onready var area_2d: Area2D = $Area2D
@onready var coli4: CollisionShape2D = $Area2D/CollisionShape2D # MAKE SURE THIS NAME MATCHES YOUR TREE
@onready var sprite = $AnimatedSprite2D

@onready var col1 = $CollisionShape2D
@onready var col2 = $CollisionShape2D2
@onready var col3 = $CollisionShape2D3

@onready var attack_timer: Timer = $AttackTimer

func _ready() -> void:
	attack_timer.wait_time = 0.6
	attack_timer.one_shot = true
	attack_timer.timeout.connect(_on_attack_timer_timeout)
	
	# Ensure the hitbox starts completely off when the scene loads/restarts
	area_2d.monitoring = false
	coli4.disabled = true 

func _physics_process(delta: float) -> void:
	# 1. Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_floor():
		jump_count = 0

	# 2. Handle Jumping
	if Input.is_action_just_pressed("jump") and jump_count < max_jumps and not is_attacking:
		jump_count += 1
		if jump_count == 1:
			velocity.y = JUMP_VELOCITY
		elif jump_count == 2:
			velocity.y = DOUBLE_JUMP_VELOCITY

	# 3. Handle Movement
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		if not is_attacking:
			sprite.flip_h = direction < 0 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 4. Handle Attacking Input
	if Input.is_action_just_pressed("attack") and not is_attacking:
		is_attacking = true
		sprite.play("attack")
		
		# Turn on the Area2D and the hitbox
		area_2d.monitoring = true
		coli4.disabled = false 
		
		if is_on_floor():
			col1.disabled = false
			col2.disabled = false
			col3.disabled = false
		else:
			col1.disabled = false
			col2.disabled = false
			col3.disabled = true
		
		attack_timer.start()

	# 5. Animation & Collider Logic (Only run if NOT attacking)
	if not is_attacking:
		# Turn off the Area2D and hitbox when not attacking
		area_2d.monitoring = false
		coli4.disabled = true
		
		if not is_on_floor():
			sprite.play("jump")
			col1.disabled = false
			col2.disabled = false 
			col3.disabled = true
		elif direction != 0:
			sprite.play("move")
			col1.disabled = false
			col2.disabled = false
			col3.disabled = false
		else:
			sprite.play("idle")
			col1.disabled = false
			col2.disabled = false 
			col3.disabled = false

	move_and_slide()

func _on_attack_timer_timeout() -> void:
	is_attacking = false
	# The Area2D and coli4 will be turned off automatically in the next _physics_process frame
