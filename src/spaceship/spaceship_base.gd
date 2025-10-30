extends CharacterBody2D
class_name SpaceshipBase

const BULLET = preload("res://src/bullet/bullet.tscn")
const FX_DMG_EXPLOSION = preload("res://src/fx/fx_explosion_dmg.tscn")
const FX_DEATH_EXPLOSION = preload("res://src/fx/fx_explosion_death.tscn")

@onready var timer: Timer = $Timer
@onready var left_gun: Node2D = $LeftGun
@onready var right_gun: Node2D = $RightGun

var max_health: int = 100
var health: int = 50
var move_speed: float = 100
var attack_speed: float = 100
var move_damping: float = 0.5
var rot_damping: float = 0.1
var damage: int = 10

var gun_to_use: int = 0

func _shoot() -> void:
	var bullet_instance = BULLET.instantiate()
	bullet_instance.target = get_global_mouse_position()
	bullet_instance.position = [left_gun, right_gun][gun_to_use].global_position
	gun_to_use = !gun_to_use
	bullet_instance.shooter = self
	bullet_instance.damage = damage
	get_parent().add_child(bullet_instance)

func apply_damage(value: int, point: Vector2) -> void:
	health -= value
	print('[damage] health:', health)
	if health <= 0:
		var fx_explosion = FX_DEATH_EXPLOSION.instantiate()
		fx_explosion.position = position
		get_parent().add_child(fx_explosion)
		die()
	else:
		var fx_explosion = FX_DMG_EXPLOSION.instantiate()
		fx_explosion.position = point
		add_child(fx_explosion)

func die() -> void:
	print('[dead]')
	self.queue_free()
