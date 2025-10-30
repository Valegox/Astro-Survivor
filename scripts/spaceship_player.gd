extends SpaceshipBase
class_name SpaceshipPlayer

var move_speed = 1000

func _physics_process(delta: float) -> void:
	process_movement()
	process_rotation()

func process_movement() -> void:
	var movement = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	velocity = movement.normalized() * move_speed
	move_and_slide()
	
func process_rotation() -> void:
	var mouse_pos = get_global_mouse_position()
	var angle = (mouse_pos - position).angle()
	rotation = PI / 2 + angle
