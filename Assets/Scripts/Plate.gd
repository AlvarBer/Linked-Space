extends Sprite


export(String) var group
var linked = []
var objects_over = 0

func _enter_tree():
	if self.group:
		self.add_to_group(self.group)

func _ready():
	if self.group:
		for node in self.get_tree().get_nodes_in_group(self.group):
			if node != self:
				self.linked.append(node)

func on_act():
	self.objects_over += 1
	self.frame = 1
	for node in self.linked:
		node.on_act()

func on_stop_act():
	self.objects_over -= 1
	if objects_over == 0:
		self.frame = 0
		for node in self.linked:
			node.on_stop_act()

func _on_Area2D_body_entered(body):
	on_act()

func _on_Area2D_body_exited(body):
	on_stop_act()

func _on_Area2D_area_entered(area):
	on_act()

func _on_Area2D_area_exited(area):
	on_stop_act()
