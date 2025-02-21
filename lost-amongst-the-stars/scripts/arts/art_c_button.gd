extends TextureButton

@onready var cooldown = $cooldown
@export var artList: artsList

@onready var enemy: CharacterBody2D = get_tree().get_first_node_in_group("enemy")
var enemyStats: stats
@export var playerStats: stats

func _ready():
	cooldown.max_value = artList.cArtCooldown
	cooldown.value = cooldown.max_value
	if enemy: 
		enemyStats = enemy.find_child("Stats Component")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("artC"):
		emit_signal("pressed")

func _on_pressed() -> void:
	if cooldown.value == 0:
		cooldown.value = cooldown.max_value
		artList.artC(playerStats)

func _on_battle_attack_landed() -> void:
	if cooldown.value <= 0:
		cooldown.value = 0
	else:
		cooldown.value -= 1
