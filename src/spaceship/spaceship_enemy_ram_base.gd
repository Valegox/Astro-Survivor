extends SpaceshipBase
class_name SpaceshipEnemyRamBase

func _ready() -> void:
	move_speed = 120

func _physics_process(delta: float) -> void:
	_process_movement()
	_process_rotation()
	
func _process_movement() -> void:
	var movement = Player.position - position
	velocity = movement.normalized() * move_speed
	move_and_slide()

func _process_rotation() -> void:
	var angle = (Player.position - position).angle()
	var target_rotation = PI / 2 + angle
	rotation = lerp_angle(rotation, target_rotation, rotation_speed)

func die() -> void:
	super()
	print('enemy died')
