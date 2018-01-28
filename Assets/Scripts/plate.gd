extends Sprite

export(String) var world
export(String) var other
export(bool) var permanent = false
onready var linked = get_node("../../../../ViewportContainer" + world + "/Viewport/Map/" + other)
var objects_over = 0

func _ready():
	pass

func pressed():
	objects_over += 1
	frame = 1
	linked.unlock()

func released():
	if !permanent:
		objects_over -= 1
		if objects_over == 0:
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
