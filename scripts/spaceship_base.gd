extends CharacterBody2D
class_name SpaceshipBase

const BULLET = preload("res://scenes/bullet.tscn")

var attack_speed = 100

func _shoot() -> void:
	var bullet_instance = BULLET.instantiate()
	bullet_instance.target = get_global_mouse_position()
	bullet_instance.position = position
	get_parent().add_child(bullet_instance)
	
