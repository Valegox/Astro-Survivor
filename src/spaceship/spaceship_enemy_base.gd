extends SpaceshipBase
class_name SpaceshipEnemyRamBase

const XPSHARD = preload("res://src/xp_shard.tscn")

func _ready() -> void:
	move_speed = 120

func _physics_process(delta: float) -> void:
	_process_movement()
	_process_rotation()
	
func _process_movement() -> void:
	var movement = Player.position - position
	var target_velocity = movement.normalized() * move_speed
	velocity = lerp(velocity, target_velocity, move_damping)
	move_and_slide()

func _process_rotation() -> void:
	var angle = (Player.position - position).angle()
	var target_rotation = PI / 2 + angle
	rotation = lerp_angle(rotation, target_rotation, rot_damping)

func die() -> void:
	super()
	var xp_shard = XPSHARD.instantiate()
	xp_shard.position = position
	get_parent().add_child(xp_shard)
	print('enemy died')
