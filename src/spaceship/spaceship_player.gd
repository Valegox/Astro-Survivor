extends SpaceshipBase
class_name SpaceshipPlayer

func _ready() -> void:
	move_speed = 500
	rotation_speed = 0.5
	damage = 10

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
	var target_rotation = PI / 2 + angle
	rotation = lerp_angle(rotation, target_rotation, rotation_speed)
