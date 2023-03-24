extends CanvasLayer

signal start_game #sinal de iniciar game

#atribui números/valor ao text do score
func update_score(score):
	$ScoreLabel.text = str(score)

#faz com que os labels sejam demonstrados ao rodar o jogo
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func show_game_over():
	#quando morre, mostra o texto game over
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	#reinicia a tela inicial do jogo para poder jogar denovo
	$MessageLabel.text = "Salve-se"
	$MessageLabel.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$Button.show()

#inicia o jogo e esconde o botão
func _on_Button_pressed():
	$Button.hide()
	emit_signal("start_game")

#ao iniciar o jogo, esconde o título do jogo
func _on_MessageTimer_timeout():
	$MessageLabel.hide()
