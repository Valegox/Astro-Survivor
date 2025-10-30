extends CharacterBody2D
class_name SpaceshipBase

const BULLET = preload("res://scenes/bullet.tscn")
@onready var timer: Timer = $Timer

var max_health: int = 100
var health: int = 50
var move_speed: float = 100
var attack_speed: float = 100

func _shoot() -> void:
	var bullet_instance = BULLET.instantiate()
	bullet_instance.target = get_global_mouse_position()
	bullet_instance.position = position
	bullet_instance.shooter = self
	get_parent().add_child(bullet_instance)

func apply_damage(value: int) -> void:
	health -= value
	print('damage: ', health)
	if health <= 0:
		die()

func die() -> void:
	print('HOOHOHOHOHOH IEM DED')
	# TODO: explosion animation
	self.queue_free()
