extends Node2D

var speed = 400
var alignment_strength = 100
var cohesion_strength = 100
var separation_strength = 100

var visual_range = 100

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	
	velocity.x += 1
	velocity = velocity.normalized() * speed
	
	
	var newPos = position + velocity * delta
	look_at(newPos)
	
	position = newPos
	# TODO - Wrap position when leaving the screen
	position = position.clamp(Vector2.ZERO, screen_size)
	pass

# Separation - steer to avoid crowding local flock mates
func separation_vector():
	pass

# Alignment - steer towards the average heading of local flock mates
func alignment_vector():
	pass
	
# Cohesion - steer to move towardthe average position of local flock mates
func cohesion_vector():
	pass

# Find Boids - get all boids within visual range
func find_boids():
	pass
