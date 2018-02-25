extends Sprite


export(String) var group
export var plates_needed = 1
var plates_pressed = 0

func _enter_tree():
	if self.group:
		self.add_to_group(self.group)

func _ready():
	pass

func on_act():
	self.plates_pressed += 1
	if self.plates_needed - self.plates_pressed <= 0:
		self.frame = 1
		$StaticBody2D/CollisionShape2D.disabled = true
		self.z_index = 2

func on_stop_act():
	self.plates_pressed -= 1
	self.frame = 0
	$StaticBody2D/CollisionShape2D.disabled = false
	self.z_index = 0

