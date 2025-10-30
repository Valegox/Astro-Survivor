extends Node2D

enum EnemyType {NORMAL, SCOUT, CRUISER, HUNTER, MONOLITH}
enum ScreenSide {LEFT, RIGHT, TOP, BOTTOM}

class EnemyZone:
	var types: Array[EnemyType]
	var initial_quantity: int
	
	func _init(types: Array[EnemyType], initial_quantity: int):
		self.types = types
		self.initial_quantity = initial_quantity	

const enemies_per_type = {
	EnemyType.NORMAL: preload("res://src/spaceship/spaceship_enemy_base.tscn"),
	EnemyType.SCOUT: preload("res://src/spaceship/spaceship_enemy_base.tscn"),
	EnemyType.CRUISER: preload("res://src/spaceship/spaceship_enemy_base.tscn"),
	EnemyType.HUNTER: preload("res://src/spaceship/spaceship_enemy_base.tscn"),
	EnemyType.MONOLITH: preload("res://src/spaceship/spaceship_enemy_base.tscn"),
}

var current_wave: int = 0
var current_zone: int = 0
var max_enemies: int
var enemies_spawned: int = 0
var enemy_types: Array[EnemyType]

var zones: Array[EnemyZone] = [
	EnemyZone.new([EnemyType.NORMAL], 5),
	EnemyZone.new([EnemyType.NORMAL], 10),
	EnemyZone.new([EnemyType.NORMAL, EnemyType.SCOUT], 8),
	EnemyZone.new([EnemyType.NORMAL, EnemyType.SCOUT], 15),
	EnemyZone.new([EnemyType.SCOUT, EnemyType.CRUISER], 10),
	EnemyZone.new([EnemyType.NORMAL, EnemyType.SCOUT, EnemyType.CRUISER], 20),
	EnemyZone.new([EnemyType.NORMAL, EnemyType.HUNTER], 10),
	EnemyZone.new([EnemyType.NORMAL, EnemyType.CRUISER, EnemyType.HUNTER], 15),
	EnemyZone.new([EnemyType.NORMAL, EnemyType.SCOUT, EnemyType.CRUISER, EnemyType.HUNTER], 25),
	EnemyZone.new([EnemyType.MONOLITH], 1),
	EnemyZone.new([EnemyType.NORMAL, EnemyType.SCOUT, EnemyType.CRUISER, EnemyType.HUNTER, EnemyType.MONOLITH], 25),
	EnemyZone.new([EnemyType.NORMAL, EnemyType.SCOUT, EnemyType.CRUISER, EnemyType.HUNTER, EnemyType.MONOLITH], 40),
]
var enemies_killed: int = 0

func _ready() -> void:
	_run_next_wave()

func _run_next_wave() -> void:
	if current_wave % 3 == 0:
		# New zone
		current_zone += 1
		max_enemies = zones[current_zone - 1].initial_quantity
		enemy_types = zones[current_zone - 1].types
	else:
		# No new zone
		max_enemies *= 2
	current_wave += 1
	enemies_killed = 0
	_spawn_enemies()

func _spawn_enemies() -> void:
	if enemies_spawned >= 1: #max_enemies:
		return
	for i in range(0, current_wave):
		enemies_spawned += 1
		var type_to_spawn = enemy_types[randi() % enemy_types.size()]
		var side: ScreenSide = randi_range(0, ScreenSide.size())
		var spawn_pos: Vector2
	
		if side == ScreenSide.LEFT:
			spawn_pos.x = -340
			spawn_pos.y = randi_range(-200, 200)
		if side == ScreenSide.RIGHT:
			spawn_pos.x = 340
			spawn_pos.y = randi_range(-200, 200)
		if side == ScreenSide.TOP:
			spawn_pos.x = randi_range(-340, 340)
			spawn_pos.y = -200
		if side == ScreenSide.BOTTOM:
			spawn_pos.x = randi_range(-340, 340)
			spawn_pos.y = 200
		
		var enemy_instance = enemies_per_type[type_to_spawn].instantiate()
		enemy_instance.position = spawn_pos
		self.add_child(enemy_instance)
