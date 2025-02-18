class_name Player
extends CharacterBody2D

@export var animationTree: AnimationTree # our reference to the animation tree
@export var runSpeed: float #how fast the player runs

var direction: Vector2 # set direction

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down").normalized() # get input
	
	if direction: #apply direction to velocity and blend spaces when player applies input
		animationTree.set("parameters/run/blend_position", direction)
		animationTree.set("parameters/idle/blend_position", direction)
		velocity = direction * runSpeed
	else: #stop player movement when player isn't applying input
		velocity = Vector2.ZERO
	move_and_slide() #do physics things
