extends ProgressBar

func trigger_scale(factor: float, duration: float) -> void:
	var initial_scale = scale
	var tween = get_parent().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, 'scale:y', scale.y * factor, duration / 2)
	tween.tween_property(self, 'scale:y', initial_scale.y, duration / 2)

func trigger_fill_color(color: Color, duration: float) -> void:
	var initial_color = get_theme_stylebox("fill").bg_color
	var tween = get_parent().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_method(
		func(c): get_theme_stylebox("fill").bg_color = c,
		color,
		initial_color,
		duration
	)
