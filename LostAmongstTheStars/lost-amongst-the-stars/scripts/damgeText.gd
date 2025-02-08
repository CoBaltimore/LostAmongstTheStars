class_name damageText
extends Node2D

var travelDistance = Vector2(0, -10)
var duration = 0.625

func displayNumber(damage: float, position: Vector2) -> void:
	$Label.text = str(damage).pad_decimals(0)
	var tween: Tween = create_tween().set_parallel(true)
	global_position = position
	tween.tween_property(self, "global_position", global_position + travelDistance, duration)
	
	tween.tween_callback(self.queue_free)
