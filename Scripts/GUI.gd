extends CanvasLayer



func _ready():
	Global.GUI = self


func update(coins, lives):
	$Banner/HBoxContainer/CoinCount.text = str(coins)
	$Banner/HBoxContainer/LifeCount.text = str(lives)


func animate(animation_name):
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play(animation_name)
