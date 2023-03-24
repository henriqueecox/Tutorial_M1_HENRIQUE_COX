extends RigidBody2D

export var min_speed = 150.0 #velocidade mínima do mob
export var max_speed = 250.0 #velocidade máxima do mob


func _ready():
	#randomiza entre os diferentes tipos de inimigos
	$AnimatedSprite.playing = true
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

#apaga o mob depois que ele sai da tela
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
