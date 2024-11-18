extends Control

var num_perguntas = 2
var max_pontos = 15 * num_perguntas
var min_pontos = 5 * num_perguntas
var high_score = 0.8 * max_pontos
var med_score = 0.5 * max_pontos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GlobalVar.pontos >= high_score:
		$Profile.text += "Energético Sustentável"
		$Description.text = "Parabéns! Seus hábitos mostram um alto nível de consciência energética. Continue assim!"
	elif GlobalVar.pontos >= med_score:
		$Profile.text += "Moderado Consciente"
		$Description.text = "Você está no caminho certo, mas ainda pode melhorar alguns aspectos do seu consumo energético."
	else:
		$Profile.text += "Desperdiçador de Energia"
		$Description.text = "Seus hábitos mostram um consumo energético elevado. Que tal revisar seus comportamentos e ajudar o planeta?"

func _on_button_pressed() -> void:
	GlobalVar.pontos = 0
	get_tree().change_scene_to_file('res://scenes/menu.tscn')
