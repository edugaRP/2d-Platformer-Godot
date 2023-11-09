extends CharacterBody2D

const SPEED = 150.0
const JUMP_FORCE = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := false
@onready var animation := $animation as AnimatedSprite2D 

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
	elif is_on_floor():
		is_jumping = false

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animation.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Call the function to handle animation
	handle_animation()

	move_and_slide()

func handle_animation():
	if is_jumping:
		animation.play("jump")
	elif velocity.x != 0:
		animation.play("run")
	else:
		animation.play("idle")
