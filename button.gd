extends Button

@onready var label = $Label

@export var hover_scale := 1.1
@export var anim_time := 0.12

func _ready():
	mouse_entered.connect(_on_hover)
	mouse_exited.connect(_on_exit)

func _on_hover():
	$Label.add_theme_font_size_override("font_size", 100)
	animate_label(Vector2(hover_scale, hover_scale))

func _on_exit():
	animate_label(Vector2(1, 1))

func animate_label(target_scale: Vector2):
	var tween = create_tween()
	tween.tween_property(label, "scale", target_scale, anim_time)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
