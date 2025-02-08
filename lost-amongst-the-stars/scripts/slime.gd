class_name slime
extends CharacterBody2D

@export var anim : AnimationPlayer #animation player
@export var moveSpeed : float = 15.0 #movement speed variable

var player : CharacterBody2D #player parent node
var playerState : Node #player stat component
var moveDirection : Vector2 #this holds the direction the slime is moving
var wanderTime : float #holds the time between direction changes

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player") #grab player node
	if player:
		playerState = player.find_child("StateMachine") #grab player stats from the player node

func randomizeWander():
	#changes the direction the slime wanders and determines the length of time the sline wanders
	moveDirection = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() 
	wanderTime = randf_range(1, 3)

func _process(delta: float) -> void:
	#checks if the wander time is over and then runs randomizeWander when its time.
	if wanderTime > 0:
		wanderTime -= delta
	else:
		randomizeWander()

func _physics_process(delta: float) -> void:
	velocity = moveDirection * moveSpeed #applies wander
	
	#if moving, play the animation
	if velocity.length() > 0:
		anim.play("move")
	move_and_slide()
