class_name field
extends State

signal buttonStart

@export var player : CharacterBody2D

var enemy : CharacterBody2D

func Enter():
	enemy = get_tree().get_first_node_in_group("enemy")

func physicsUpdate(delta: float):
	var direction: Vector2
	if is_instance_valid(enemy):
		direction = player.global_position - enemy.global_position
		
		if direction.length() < 75:
			Transitioned.emit(self, "battle")
			emit_signal("buttonStart")
