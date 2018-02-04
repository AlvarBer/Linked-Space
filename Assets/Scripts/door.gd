extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var plates_connected = 1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func unlock():
	plates_connected -= 1
	if plates_connected <= 0:
		frame = 1
		$StaticBody2D/CollisionShape2D.disabled = true
		self.z_index = 2

func lock():
	plates_connected += 1
	frame = 0
	$StaticBody2D/CollisionShape2D.disabled = false
	self.z_index = 0

