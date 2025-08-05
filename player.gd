extends CharacterBody2D


const SPEED = 1000.0
const JUMP_VELOCITY = -700.0

var is_ready : bool = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, SPEED*direction, 100)
	else:
		velocity.x = move_toward(velocity.x, 0, 100)
		
	if Input.is_action_just_pressed("dash"):
		if is_ready:
			position.x += 500*direction
			is_ready = false
			$Timer.start()
		
	move_and_slide()
	
func _on_timer_timeout():
	is_ready = true
	
	
