extends CanvasLayer

@onready var label = $TextContent/MarginContainer/HBoxContainer/Label
@onready var end = $TextContent/MarginContainer/HBoxContainer/End
var skip: bool
var is_on := false
signal next

func _ready():
	hide()
	
func _input(event):
	if event.is_action_pressed("Start") and is_on:
		skip = true
		next.emit()

func say(text_said: String):
	var cursor := 0
	skip = false
	get_tree().paused = true
	show()
	label.text = ""
	$Timer.start()
	await $Timer.timeout
	is_on = true
	while cursor < text_said.length():
		if text_said[cursor] == "+":
			end.show()
			await next
			end.hide()
			label.text = ""
			cursor += 1
			skip = false
		else:
			label.text += text_said[cursor]
			cursor += 1
			if not skip:
				await $Timer.timeout
	$Timer.stop()
	await next
	is_on = false
	get_tree().paused = false
	hide()
