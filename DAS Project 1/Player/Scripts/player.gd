extends CharacterBody2D

@export var walk_speed = 400

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("walk_left"):
		velocity.x -= 1
	if Input.is_action_pressed("walk_right"):
		velocity.x += 1
	if Input.is_action_pressed("walk_down"):
		velocity.y += 1
	if Input.is_action_pressed("walk_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * walk_speed
	
	position += velocity * delta
	velocity = move_and_slide()
