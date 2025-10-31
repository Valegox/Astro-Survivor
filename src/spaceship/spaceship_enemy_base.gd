extends SpaceshipBase
class_name SpaceshipEnemyRamBase

const XPSHARD = preload("res://src/xp_shard.tscn")

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $UIHealthBar

func _ready() -> void:
	move_speed = 120
	move_damping = 0.5
	rot_damping = 0.7
	health_bar.value = health
	max_health = 50
	health = 50

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
	sprite.rotation = lerp_angle(rotation, target_rotation, rot_damping)

func apply_damage(value: int, point: Vector2) -> void:
	super(value, point)
	health_bar.value = health
	health_bar.trigger_scale(2.5, .35)
	health_bar.trigger_fill_color(Color.HOT_PINK, 0.4)

func die() -> void:
	super()
	var xp_shard = XPSHARD.instantiate()
	xp_shard.position = position
	get_parent().add_child(xp_shard)
	var hud = get_parent().get_node("Hud")
	hud.trigger_score()
	print('enemy died')
