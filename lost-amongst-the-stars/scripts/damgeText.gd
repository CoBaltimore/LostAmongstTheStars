class_name damageText
extends Node2D

var travelDistance = Vector2(0, -10)
var duration: float = 0.75

func displayNumber(damage: String, position: Vector2) -> void:
	$Label.text = damage
	var tween: Tween = create_tween().set_parallel(true)
	global_position = position
	
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(tween.TRANS_QUAD)
	
	tween.tween_property(self, "global_position", global_position + travelDistance, duration)
	tween.chain().tween_callback(self.queue_free)
