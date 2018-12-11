extends Area2D



var _already_taken = false


func _on_body_entered(body):
	if not _already_taken:
		_already_taken = true
		Global.GameState.pickup_coin()
		$AnimationPlayer.play("die")
		$Coin_SFX.play()
