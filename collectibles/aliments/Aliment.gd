extends Area2D

var health_amount: int = 10
var heath_map = {
	0: 25,  # blackberries
	1: 25,  # tomato
	2: 25,  # orange
	3: 25,  # grape
	4: 25,  # watermelon
	5: 25,  # strawberry
	6: 25,  # perry
	7: 25,  # lemon
	8: 25,  # ananas
	9: 25,  # banana
	10: 25, # acorn
	11: 25, # radish
	12: 25, # red pepper
	13: 25, # green pepper
	14: 25, # yellow pepper
	15: 25, # bread
	16: 25, # cacke
	17: 25, # cheese
	18: 25, # fish
	20: 25, # meat
	22: 25  # carrot
}
var rng = RandomNumberGenerator.new()

func _ready():
	connect('body_entered', self, '_on_Player_enter')
	_random_aliment()
	set_monitoring(false)
	$Sprite.hide()
	$AnimationPlayer.play('Explosion')


func _random_aliment() -> void:
	rng.randomize()
	var id:int = rng.randi_range(0, heath_map.size())
	$Sprite.set_frame(id)


func _on_Player_enter(body: Player) -> void:
	assert body is Player
	body.get_node('Health').recover_health(health_amount)
	queue_free()