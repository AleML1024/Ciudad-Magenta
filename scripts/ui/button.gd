extends SoundButton

@onready var label = $Label

@export var hover_scale := 1.1
@export var anim_time := 0.12

var tween


func _ready():

	super._ready()

	mouse_entered.connect(_on_hover)
	mouse_exited.connect(_on_exit)


func _on_hover():

	animate_label(
		Vector2(hover_scale, hover_scale)
	)


func _on_exit():

	animate_label(Vector2.ONE)


func animate_label(target_scale: Vector2):

	if tween:
		tween.kill()

	tween = create_tween()

	tween.tween_property(
		label,
		"scale",
		target_scale,
		anim_time
	).set_trans(
		Tween.TRANS_SINE
	).set_ease(
		Tween.EASE_OUT
	)
