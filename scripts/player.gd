extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 7
var rotation_speed: float = 3.0

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var rotation_input = Input.get_axis("ui_right", "ui_left")
	rotate_y(rotation_input * rotation_speed * delta)
	
	var forward_input = Input.get_axis("ui_down", "ui_up")
	var direction = (-transform.basis.z * forward_input).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
