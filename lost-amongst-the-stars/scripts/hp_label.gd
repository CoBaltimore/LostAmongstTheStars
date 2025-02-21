extends Control

@export var playerStats: stats
@export var hpLabel: Label
@export var hpBar: TextureProgressBar

func _on_battle_damage_recieved() -> void:
	hpLabel.text = str(playerStats.hp).pad_decimals(0)
	hpBar.value = playerStats.hp
