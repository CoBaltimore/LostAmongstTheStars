extends Control

func _ready() -> void:
	self.hide()

func _on_field_button_start() -> void:
	self.show()

func _on_battle_buttons_stop() -> void:
	self.hide()
