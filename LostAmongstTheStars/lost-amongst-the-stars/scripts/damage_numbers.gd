extends Node

func displayNumber(value: int, position: Vector2):
	var number = Label.new()
	number.global_position = position
	number.text = str(int(value))
	if value == 0:
		number.text = "MISS"
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	
	var color = "#000"
	
	number.label_settings.font_color = color
	number.label_settings.font_size = 10
	
	call_deferred("add_child", number)
	
