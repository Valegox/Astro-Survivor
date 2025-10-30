extends SpaceshipBase
class_name SpaceshipPlayer

var move_speed = 1000

func _physics_process(delta: float) -> void:
	process_movement()
	process_rotation()

func process_movement() -> void:
	var movement = Vector2(0, 0)
	if (Input.is_action_pressed("move_up")):
		movement.y -= 1
	if (Input.is_action_pressed("move_down")):
		movement.y += 1
	if (Input.is_action_pressed("move_left")):
		movement.x -= 1
	if (Input.is_action_pressed("move_right")):
		movement.x += 1
	velocity = movement.normalized() * move_speed
	move_and_slide()
	
func process_rotation() -> void:
	var mouse_pos = get_global_mouse_position()
	var angle = (mouse_pos - position).angle()
	rotation = PI / 2 + angle
