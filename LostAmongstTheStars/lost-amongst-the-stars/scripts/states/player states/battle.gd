class_name battle
extends State

#reference to proper player nodes
@export var playerStats: stats #player's stat component
@export var player: CharacterBody2D #player's parent node
@export var autoCooldownTimer: Timer #player's cooldown timer

#reference to proper enemy nodes
var enemy: CharacterBody2D #enemy's parent node
var enemyStats: stats #enemy's stats component
var enemyAutoCooldownTimer: Timer #enemy's cooldown timer

func Enter():
	enemy = get_tree().get_first_node_in_group("enemy") #grab enemy from node group
	
	#if theres an enemy in the group, grab enemy's stat and timer component
	if enemy: 
		enemyStats = enemy.find_child("Stats Component")
		enemyAutoCooldownTimer = enemy.find_child("AutoCooldown")

func physicsUpdate(delta: float):
	var distance: Vector2 #this will be used to measure the distance between the enemy and the player
	
	#If the enemy has been detected, go through with the battle.
	#if I don't add this if block, the game freaks out when the enemy is gone.
	if enemy:
		distance  = player.global_position - enemy.global_position #measure distance as mentioned
		if playerStats.checkForLife(): #check the player's hp stat for if its above zero
			enemy.moveSpeed = 0 #stop the enemy's movement pattern\
			#play the auto attack functions
			playerAutoAttack() 
			enemyAutoAttack()
		else: # if player hp is 0, play defeat state
			Transitioned.emit(self, "defeat")
		#check enemy hp. If dead, delete enemy, restore player HP, and return to field state.
		if !enemyStats.checkForLife():
			playerStats.resetHP()
			enemy.queue_free()
			Transitioned.emit(self, "field")
		#if the distance between the player and enemy is long enough,
		#reset hp and return to field state
		if distance.length() >= 150:
			playerStats.resetHP()
			enemyStats.resetHP()
			Transitioned.emit(self, "field")

func playerAutoAttack():
	#check if the cooldown is over.
	#if so, restart the timer and play the damage function on the enemy's stat component
	if playerStats.isCooled:
		autoCooldownTimer.start()
		enemyStats.damage(playerStats)
		playerStats.isCooled = false # this tells the game that the cooldown is in effect.

func enemyAutoAttack():
	#check if enemy's cooldown is lower.
	#if so, restart timer and play the player's damage function
	if enemyStats.isCooled:
		enemyAutoCooldownTimer.start()
		playerStats.damage(enemyStats)
		enemyStats.isCooled = false #this tells the game that the cooldown is in effect.
