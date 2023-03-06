extends Node2D

#var teste e valor não tinham funcionalidade
var numero = 0
var lista = []
var nome = "henrique" #ja deixar um nome definido para variável

func _on_Button_pressed():
# Coletando dados inseridos pelo usuário
# Erros ortográficos corrigidos com "Numero", corrigido para "numero"
# Outro lineedit eliminado
	numero = int($LineEdit.text)

func _on_Button2_pressed():
# Incrementando o número inserido pelo usuário
	for i in range(10):
		numero += i
		lista.append(numero)
	$Label.text = str(numero)

func _on_Button3_pressed():
	# Mudando o nome do usuário de acordo com os dados da lista
	# Se houver algum número ímpar o nome deve adicionar "baldo" ao final
	var cont = 0 #var cont declarada por fora
	#while trocado para for
	#i = 0  eliminado porque ja esta declarado
	for i in range(len(lista)):
		if lista[i] % 2 == 1:
			cont += 1
		if cont != 0:
			nome = nome + "baldo"
	$Label2.text = nome
	
	
