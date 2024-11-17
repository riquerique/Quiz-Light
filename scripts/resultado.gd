extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GlobalVar.pontos >= 20:
		$Profile.text += "Energético Sustentável"
		$Description.text = "Parabéns! Seus hábitos mostram um alto nível de consciência energética. Continue assim!"
	elif GlobalVar.pontos >= 10:
		$Profile.text += "Moderado Consciente"
		$Description.text = "Você está no caminho certo, mas ainda pode melhorar alguns aspectos do seu consumo energético."
	else:
		$Profile.text += "Desperdiçador de Energia"
		$Description.text = "Seus hábitos mostram um consumo energético elevado. Que tal revisar seus comportamentos e ajudar o planeta?"

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file('res://scenes/menu.tscn')
