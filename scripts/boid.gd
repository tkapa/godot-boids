extends Node2D

var speed = 400
var alignment_strength = 0.5
var cohesion_strength = 1
var separation_strength = 1
var visual_range = 100

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group('boids')
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	var nearby = find_boids()
	
	velocity += separation_vector(nearby) * separation_strength
	velocity += alignment_vector() * alignment_strength
	velocity += cohesion_vector() * cohesion_strength
	
	velocity = velocity.normalized() * speed
	
	var newPos = position + velocity * delta
	look_at(newPos)
	
	position = newPos
	position = position.clamp(Vector2.ZERO, screen_size)
	pass

# Separation - steer to avoid crowding local flock mates
func separation_vector(nearby):
	var velocity = Vector2.ZERO
	if (nearby.size() > 0):
		velocity.x = randf_range(-0.5,0.5)
		velocity.y = randf_range(-0.5,0.5)
	return velocity
	
# Alignment - steer towards the average heading of local flock mates
func alignment_vector():
	var velocity = Vector2.ZERO
	return velocity
	
# Cohesion - steer to move towardthe average position of local flock mates
func cohesion_vector():
	var velocity = Vector2.ZERO
	return velocity

# Find Boids - get all boids within visual range
func find_boids():
	var boids = get_tree().get_nodes_in_group("boids")
	var nearbyBoids = []
	
	for b in boids:
		if (b.position == position):
			continue
			
		var y = b.position.y - position.x
		var x = b.position.x - position.x
		var dist = sqrt(pow(y, 2) - pow(x, 2))
		
		if (dist < visual_range):
			nearbyBoids.push_front(b)
		
	return nearbyBoids
