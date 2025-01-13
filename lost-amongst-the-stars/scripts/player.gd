class_name Player
extends CharacterBody2D

@export var animation_tree: AnimationTree # our reference to the animation tree
@export var runSpeed: float #how fast the player runs
var targetVelocity = Vector2.ZERO #target velocity which gets edited and applied to real velocity
var lastFacingDirection := Vector2(0, -1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2.ZERO # reset the direction value
	
	#apply the direction value based on which button is being pressed
	if Input.is_action_pressed("right"): #input for right
		direction.x += 1 #positive is right
	if Input.is_action_pressed("left"): #input for left
		direction.x -= 1 #negative is left
	if Input.is_action_pressed("up"): #input for up
		direction.y -= 1 #negative is up
	if Input.is_action_pressed("down"): #input for down
		direction.y += 1 #positive is down
	
	#apply direction value and speed to target velocity
	targetVelocity.x = direction.x * runSpeed #horizontal
	targetVelocity.y = direction.y * runSpeed #vertical
	velocity = targetVelocity #apply target velocity to actual velocity
	
	var idle = !velocity #set idle bool
	if !idle: # check if the player isn't idle
		lastFacingDirection = velocity.normalized() # set the direction of the sprite
	
	animation_tree.set("parameters/run/blend_position", lastFacingDirection) # play run animation
	animation_tree.set("parameters/idle/blend_position", lastFacingDirection) # set animation to idle
	
	move_and_slide() #do physics things
