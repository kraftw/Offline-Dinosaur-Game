extends CharacterBody2D

const GRAVITY : int = 5200
const JUMP_SPEED : int = -1800

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		if not get_parent().game_running:
			$AnimatedSprite2D.play("idle")
		else:
			$RunCollision.disabled = false
			if Input.is_action_just_pressed("ui_accept"):
				velocity.y = JUMP_SPEED
				$JumpSound.play()
			elif Input.is_action_pressed("ui_down"):
				$AnimatedSprite2D.play("duck")
				$RunCollision.disabled = true
			else:
				$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("jump")
		if Input.is_action_just_released("ui_accept") and velocity.y < (JUMP_SPEED / 2):
			velocity.y = JUMP_SPEED / 2
		
	move_and_slide()
