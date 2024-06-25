extends Area2D

@export var destination: String

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(teleport_body)

func teleport_body(player):
	var next_node = get_tree().current_scene.get_node(destination)
	if next_node.get_node("Cooldown").is_stopped():
		player.transition()
		await player.blacked
		player.position = next_node.position + $Marker.position
		$Cooldown.start()
