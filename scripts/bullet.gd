extends CharacterBody2D
class_name Bullet

const SPEED = 300.0
const AUTODESTROY_TRESHOLD_DISTANCE = 1000

var shooter: SpaceshipBase
var initial_pos: Vector2
var target: Vector2

func _ready() -> void:
	initial_pos = position
	rotation = (target - position).angle()

func _physics_process(delta: float) -> void:
	_process_movement()
	_process_autodestroy()

func _process_movement() -> void:
	var new_velocity = (target - initial_pos).normalized() * SPEED
	velocity = new_velocity
	move_and_slide()

func _process_autodestroy() -> void:
	if position.distance_to(initial_pos) > AUTODESTROY_TRESHOLD_DISTANCE:
		self.queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is SpaceshipBase and body != shooter:
		var victim: SpaceshipBase = body
		victim.apply_damage(10)
		self.queue_free()
