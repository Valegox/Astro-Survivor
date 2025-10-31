extends CanvasLayer

@onready var score_label: Label = $ScoreLabel

func _ready() -> void:
	score_label.hide()

func trigger_score() -> void:
	var factor = 1.5
	var duration = 0.25
	var tween = get_parent().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	score_label.show()
	tween.tween_property(score_label, 'scale', scale * factor, 0.15)
	tween.tween_property(score_label, 'scale', Vector2.ZERO, 0.4)
	await tween.finished
	score_label.hide()
