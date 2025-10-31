extends Camera2D

@export var shake_decay : float = 0.8
@export var shake_max_offset : Vector2 = Vector2(100, 75)
@export var shake_max_roll : float = 0.1

var shake_trauma : float = 0.0
var shake_trauma_power : int = 2

func _ready() -> void:
	randomize()

func _process(delta: float) -> void:
	if shake_trauma:
		shake_trauma = max(shake_trauma - shake_decay * delta, 0)
		shake()

func trigger_shake(amount: float) -> void:
	shake_trauma = min(shake_trauma + amount, 1.0)

func shake() -> void:
	var shake_amount = pow(shake_trauma, shake_trauma_power)
	rotation = shake_max_roll * shake_amount * randf_range(-1, 1)
	offset.x = shake_max_offset.x * shake_amount * randf_range(-1, 1)
	offset.y = shake_max_offset.y * shake_amount * randf_range(-1, 1)

func trigger_zoom(factor: float, duration: float) -> void:
	var current_zoom = zoom
	var tween = get_parent().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, 'zoom', zoom * factor, duration / 2)
	tween.tween_property(self, 'zoom', zoom, duration / 2)
