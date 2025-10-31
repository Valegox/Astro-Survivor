extends SpaceshipBase
class_name SpaceshipPlayer

@onready var hud: CanvasLayer = $Hud

var xp: int = 0
var level: int = 1

func _ready() -> void:
	move_speed = 350
	move_damping = 0.15
	rot_damping = 0.5
	damage = 10
	var hud = get_parent().get_node("Game").get_node("Hud")
	health_bar = hud.get_node("HealthBar")
	health_bar.set_health(health, max_health)

func _physics_process(delta: float) -> void:
	process_movement()
	process_rotation()
	process_level()

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

func process_level() -> void:
	if xp >= 50:
		level += 1
		max_health += 10
		damage += 10
		attack_speed += 20
		xp = 0
		var xp_anim = $XpAnim
		xp_anim.show()
		xp_anim.play()
		await xp_anim.animation_finished
		xp_anim.hide()
