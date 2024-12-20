extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GlobalVar.pontos >= 75:
		$Profile.text = "Família Responsável"
		$Description.text = "Parabéns! Vocês têm hábitos exemplares de consumo consciente de água. Continuem assim e inspire
outras pessoas!"
		$Icon.texture = load('res://Assets/Questions/Light/Images/3.png')
		
	elif GlobalVar.pontos >= 45:
		$Profile.text = "Família Atenta"
		$Description.text = "Vocês estão no caminho certo, mas ainda pode melhorar. Pequenas mudanças podem fazer uma grande
diferença no consumo!"
		$Icon.texture = load('res://Assets/Questions/Light/Images/2.png')
	else:
		$Profile.text = "Família Distraída"
		$Description.text = "Há espaço para melhorias nos seus hábitos de consumo de água. Que tal começar adotando algumas
práticas simples?"
		$Icon.texture = load('res://Assets/Questions/Light/Images/1.png')

func _on_button_pressed() -> void:
	GlobalVar.pontos = 0
	get_tree().change_scene_to_file('res://scenes/menu.tscn')
