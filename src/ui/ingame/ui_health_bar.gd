extends ProgressBar
class_name UIHealthBar

var scaling: bool = false

func set_health(health: int, max_health: int) -> void:
	value = 100 * health / max_health

func trigger_scale(factor: float, duration: float) -> void:
	if scaling:
		return
	scaling = true
	var initial_scale = scale
	var tween = get_parent().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, 'scale:y', scale.y * factor, duration / 2)
	tween.tween_property(self, 'scale:y', initial_scale.y, duration / 2)
	await tween.finished
	scaling = false

func trigger_fill_color(color: Color, duration: float) -> void:
	var test = get_theme_stylebox("fill").duplicate()
	add_theme_stylebox_override("fill", test)
	var initial_color = test.bg_color
	var tween = get_parent().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_method(
		func(c): test.bg_color = c, #get_theme_stylebox("fill").bg_color = c,
		color,
		initial_color,
		duration
	)
