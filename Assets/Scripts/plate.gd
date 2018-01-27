extends Sprite

export(String) var world
export(String) var other
export(bool) var permanent = false
onready var linked = get_node("../../../../ViewportContainer" + world + "/Viewport/Map/" + other)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Area2D_body_entered( body ):
	frame = 1
	linked.unlock()

func _on_Area2D_body_exited( body ):
	if !permanent:
		frame = 0
		linked.lock()

