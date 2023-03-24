extends Area2D

signal hit

export var speed = 400.0 #velocidade do  player
var screen_size = Vector2.ZERO #delimitação tela

func _ready():
	#Descobre o tamanho exato da tela para poder criar limites
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	#Movimenta o personagem nas teclas W,S,A,D.
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	
	#Faz com que a movimentação do personagem ative a animação
	if direction.length() > 0:
		direction = direction.normalized()
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	#movimentação  do personagem
	position += direction * speed * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	#Flipa a imagem do personagem para dar sensação de movimento
	if direction.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_h = direction.x < 0
		$AnimatedSprite.flip_v = false 
	elif direction.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = direction.y > 0

#respawna ou reaparece o player quando recomeça o jogo
func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.disabled = false
	
#esconde o player quando ele morre
func _on_Player_body_entered(body):
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	emit_signal("hit")
