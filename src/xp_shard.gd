extends CharacterBody2D
class_name XpShard


const xp_value = 25

var initial_pos: Vector2

func _ready() -> void:
	initial_pos = position
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is SpaceshipBase:
		var player: SpaceshipBase = body
		if player is SpaceshipPlayer:
			player.xp += xp_value
			self.queue_free()
			print(player.xp)
			print(player.level)
