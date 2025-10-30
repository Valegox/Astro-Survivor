extends CharacterBody2D
const SPEED = 300.0

var initial_pos: Vector2
var target: Vector2

func _ready() -> void:
	initial_pos = position
	rotation = (target - position).angle()

func _physics_process(delta: float) -> void:
	var new_velocity = (target - initial_pos).normalized() * SPEED
	velocity = new_velocity
	move_and_slide()
