extends KinematicBody2D


const RUN_SPEED = 750
const JUMP_SPEED = -1750
const JUMP_BOOST = 2
const GRAVITY = 5250
const UP = Vector2(0, -1)

var motion = Vector2()



func _process(delta):
	# Jumping
	if motion.y < 0:
		$AnimatedSprite.play("jump")
	# Moving right
	elif motion.x > 0:
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false
	# Moving left
	elif motion.x < 0:
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true
	# Idling
	else:
		$AnimatedSprite.play("idle")


func hurt():
	motion.y = JUMP_SPEED
	$Hurt_SFX.play()


func boost_jump():
	motion.y = JUMP_SPEED * JUMP_BOOST
	$Jump_SFX.play()


func _physics_process(delta):
	_fall_process(delta)
	_run_process()
	_jump_process()
	
	move_and_slide(motion, UP)


func _fall_process(delta):
	if is_on_floor() or is_on_ceiling():
		motion.y = 0
	else:
		motion.y += GRAVITY * delta


func _run_process():
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = RUN_SPEED
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = -RUN_SPEED
	else:
		motion.x = 0


func _jump_process():
	if Input.is_action_pressed("ui_up") and is_on_floor():
		motion.y = JUMP_SPEED
		$Jump_SFX.play()
