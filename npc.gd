extends StaticBody2D

var player_on := false

func _ready():
	$Talk_area.body_entered.connect(altera_estado)
	$Talk_area.body_exited.connect(altera_estado)
	
func _input(event):
	if event.is_action_pressed("Start") and player_on:
		Dialogue.say("Olá eu sou o godotinho!+Seu amiguinho... vamos codar?")
	
func altera_estado(_body):
	player_on = !player_on
	print("alterou")
