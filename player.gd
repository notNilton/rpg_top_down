extends CharacterBody2D

@onready var blackout = $Camera/Blackout
@onready var blackout_timer = $Camera/Blackout_timer

const SPEED = 300.0

signal blacked

func _physics_process(_delta):
	var direction = Input.get_vector("Left","Right","Up","Down")
	velocity = direction * SPEED
	if direction.x < 0:
		$Sprite.play("left")
	elif direction.x > 0:
		$Sprite.play("right")
	elif direction.y == -1:
		$Sprite.play("up")
	elif direction.y == 1:
		$Sprite.play("down")
	else:
		$Sprite.pause()
		$Sprite.frame = 0
	move_and_slide()
	
func transition():
	blackout_timer.start()
	get_tree().paused = true
	while blackout.color.a < 1.0:
		blackout.color.a += 0.05
		await blackout_timer.timeout
	$Camera.position_smoothing_enabled = false
	get_tree().paused = false
	blacked.emit()
	await blackout_timer.timeout
	$Camera.position_smoothing_enabled = true
	while blackout.color.a > 0.0:
		blackout.color.a -= 0.05
		await blackout_timer.timeout
	blackout_timer.stop()
