extends SpaceshipBase
class_name SpaceshipPlayer

var xp: int = 0
var level: int = 1

func _ready() -> void:
	move_speed = 350
	move_damping = 0.15
	rot_damping = 0.5
	damage = 10

func _physics_process(delta: float) -> void:
	process_movement()
	process_rotation()

func process_movement() -> void:
	var movement = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	var target_velocity = movement.normalized() * move_speed
	velocity = lerp(velocity, target_velocity, move_damping)
	move_and_slide()
	
func process_rotation() -> void:
	var mouse_pos = get_global_mouse_position()
	var angle = (mouse_pos - position).angle()
	var target_rotation = PI / 2 + angle
	rotation = lerp_angle(rotation, target_rotation, rot_damping)

		
