extends Node

export (PackedScene) var mob_scene #puxa o grupo dos mobs
var score = 0 #váriavel do placar

#os numeros gerados são sempre diferentes
func _ready():
	randomize()

#inicia novo score toda vez que inicia o jogo novamente
func new_game():
	#redefine e recomeça a contagem do score
	score = 0
	$HUD.update_score(score)
	
	#inicia os mobs
	get_tree().call_group("mobs", "queue_free")
	#define a posição do player no começo do jogo
	$Player.start($StartPosition.position)
	
	#inicia o score
	$ScoreTimer.start()
	#faz display do texto se prepare antes do jogo começar
	$HUD.show_message("Se prepare...")
	#inicia a contagem do score e spawn dos mobs
	$StartTimer.start()
	yield($StartTimer, "timeout")
	$MobTimer.start()
	#inicia a musica
	$Music.play()
	#esconde os créditos 
	$HUD/Creditos.hide()

func game_over():
	#para o score ao game over
	$ScoreTimer.stop()
	#para a vinda de mobs ao game over
	$MobTimer.stop()
	#mostra tela de game over
	$HUD.show_game_over()
	#musica de game over é tocada
	$DeathSound.play()
	#musica normal é pausada
	$Music.stop()
	

#define os spawns dos mobs
func _on_Timer_timeout():
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.unit_offset = randf()
	
	#adiciona mais mobs
	var mob = mob_scene.instance()
	add_child(mob)
	
	#define de onde eles devem sair
	mob.position = mob_spawn_location.position
	
	#faz com que ele ande em 90 graus, mas mirado em ângulos aleatórios
	var direction = mob_spawn_location.rotation + PI / 2 
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	#faz com que os mobs se movimentes
	var velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = velocity.rotated(direction)


#aumenta o score conforme o tempo passa
func _on_ScoreTimer_timeout():
	score += 1 
	$HUD.update_score(score)
