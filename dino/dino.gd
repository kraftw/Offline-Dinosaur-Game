extends CharacterBody2D

const GRAVITY : int = 5200
const JUMP_SPEED : int = -1800
var STRAFE_SPEED : int

const left_strafe_bound : int = 704
const right_strafe_bound : int = 254

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		if not get_parent().game_running:
			$AnimatedSprite2D.play("idle")
		else:
			$RunCollision.disabled = false
			if Input.is_action_just_pressed("jump_action"):
				velocity.y = JUMP_SPEED
				$JumpSound.play()
			elif Input.is_action_pressed("duck_action"):
				$AnimatedSprite2D.play("duck")
				$RunCollision.disabled = true
			else:
				$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("jump")
		if Input.is_action_just_released("jump_action") and velocity.y < (JUMP_SPEED / 2):
			velocity.y = JUMP_SPEED / 2
	
	STRAFE_SPEED = get_parent().speed
	if Input.is_action_pressed("strafe_left"):
		check_strafe_bounds()
		position.x -= STRAFE_SPEED * 1.5
	elif Input.is_action_pressed("strafe_right"):
		check_strafe_bounds()
		position.x += STRAFE_SPEED
	
	move_and_slide()

func check_strafe_bounds():
	if $"../Camera2D".position.x - position.x > left_strafe_bound:
		position.x = $"../Camera2D".position.x - left_strafe_bound
	elif $"../Camera2D".position.x - position.x < right_strafe_bound:
		position.x = $"../Camera2D".position.x - right_strafe_bound
