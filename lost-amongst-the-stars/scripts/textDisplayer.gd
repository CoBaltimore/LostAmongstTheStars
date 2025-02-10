class_name damageDisplayer
extends Node

const DAMAGE_TEXT = preload("res://scenes/damage_text.tscn")

func damageText(damage: String, position: Vector2) -> void:
	var t: damageText = DAMAGE_TEXT.instantiate()
	add_child(t)
	t.displayNumber(damage, position)
