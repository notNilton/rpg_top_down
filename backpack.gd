extends CenterContainer

func _ready():
	hide()

func _process(_delta):
	if Input.is_action_just_pressed("Tab"):
		visible = !visible
