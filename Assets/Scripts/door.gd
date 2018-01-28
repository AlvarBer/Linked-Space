extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var plates_connected = 1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func unlock():
	plates_connected -= 1
	if plates_connected == 0:
		frame = 1
		$StaticBody2D/CollisionShape2D.disabled = true
	
func lock():
	plates_connected += 1
	frame = 0
	$StaticBody2D/CollisionShape2D.disabled = false
	
