class_name stats
extends Node2D
signal attackLanded

#declare stat variables. Exported for easy editing
@export var MAXHP: float = 10.0 #maximum health
var hp: float #current health.
@export var pow: float = 1.0 #attack strength.
@export var def: float = 1.0 #reduces attack damage.
@export var dex: float = 5.0 #determines chances of dodging attacksdddd

var dexRoll = RandomNumberGenerator.new() #rolls number that determines whether an attack is dodged
var isCooled = true # tells the stat block if the timer for autoAttaks are cooled

var broken: bool = false
var toppled: bool = false
var dazed: bool = false

@export var damageNumbers: Node2D # origin for the damage number appearance
@export var autoCooldown: Timer

func _ready(): 
	hp = MAXHP #set hp to max at start of game

func resetHP():
	hp = MAXHP #reset the hp

func damage(attack: stats, artModifier: float = 1.0) -> bool:
	#the dex stat determines how high both parties can roll.
	var reciever = dexRoll.randf_range(1, dex) #roll for dodge
	var attacker = dexRoll.randf_range(1, attack.dex) # roll for hit
	var damage = ((attack.pow - def) + 1) * artModifier #calculate damage
	var damageText = str(damage).pad_decimals(0)
	# if attacker rolls higher than reciever, then land the hit
	var land: bool
	if attacker >= reciever:
		hp -= damage #remove hp
		land = true
	else:
		damageText = "MISS"
		land = false
	textDisplayer.damageText(damageText, damageNumbers.global_position)
	return land

#checks the hp and tells whether the HP has reached/passed 0.
func checkForLife() -> bool:
	if hp <= 0:
		return false
	return true

#this signal tells the stat block whether the cooldown for their autoAttack is over.
func _on_auto_cooldown_timeout() -> void:
	isCooled = true

func _break():
	broken = true
	print("Broken!")
	await get_tree().create_timer(6.0).timeout
	print("No longer broken!")
	broken = false

func topple():
	toppled = true
	autoCooldown.stop()
	print("Toppled!")
	await get_tree().create_timer(6.0).timeout
	print("No longer toppled!")
	autoCooldown.start()
	toppled = false

func daze():
	dazed = true
	await get_tree().create_timer(6.0).timeout
	dazed = false
