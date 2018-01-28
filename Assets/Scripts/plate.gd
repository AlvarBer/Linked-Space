extends Sprite

export(String) var world_0
export(String) var other_0
export(String) var world_1
export(String) var other_1
export(String) var world_2
export(String) var other_2
export(String) var world_3
export(String) var other_3
export(bool) var permanent = false
var linked_0
var linked_1
var linked_2
var linked_3
var objects_over = 0

func _ready():
	if world_0 && other_0:
		linked_0 = get_node("../../../../ViewportContainer" + world_0 + "/Viewport/Map/" + other_0)
	if world_1 && other_1:
		linked_1 = get_node("../../../../ViewportContainer" + world_1 + "/Viewport/Map/" + other_1)
	if world_2 && other_2:
		linked_2 = get_node("../../../../ViewportContainer" + world_2 + "/Viewport/Map/" + other_2)
	if world_3 && other_3:
		linked_3 = get_node("../../../../ViewportContainer" + world_3 + "/Viewport/Map/" + other_3)
	pass

func pressed():
	objects_over += 1
	frame = 1
	if linked_0:
		linked_0.unlock()
	if linked_1:
		linked_1.unlock()
	if linked_2:
		linked_2.unlock()
	if linked_3:
		linked_3.unlock()

func released():
	if !permanent:
		objects_over -= 1
		print(objects_over)
		if objects_over == 0:
			frame = 0
			if linked_0:
				linked_0.lock()
			if linked_1:
				linked_1.lock()
			if linked_2:
				linked_2.lock()
			if linked_3:
				linked_3.lock()

func _on_Area2D_body_entered(body):
	pressed()

func _on_Area2D_body_exited(body):
	released()

func _on_Area2D_area_entered(area):
	pressed()

func _on_Area2D_area_exited(area):
	released()
