extends Sprite

export(String) var world
export(String) var other
export(bool) var permanent = false
onready var linked = get_node("../../../../ViewportContainer" + world + "/Viewport/Map/" + other)

func _ready():
	pass

func pressed():
	frame = 1
	linked.unlock()

func released():
	if !permanent:
		frame = 0
		linked.lock()

func _on_Area2D_body_entered(body):
	pressed()

func _on_Area2D_body_exited(body):
	released()

func _on_Area2D_area_entered(area):
	pressed()

func _on_Area2D_area_exited(area):
	released()
