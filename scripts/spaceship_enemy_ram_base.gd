extends SpaceshipBase
class_name SpaceshipEnemyRamBase

@onready var player: SpaceshipPlayer = %SpaceshipPlayer

func _ready() -> void:
	move_speed = 120

func _physics_process(delta: float) -> void:
	_process_movement()
	_process_rotation()
	
func _process_movement() -> void:
	var movement = player.position - position
	velocity = movement.normalized() * move_speed
	move_and_slide()

func _process_rotation() -> void:
	var angle = (player.position - position).angle()
	rotation = PI / 2 + angle
