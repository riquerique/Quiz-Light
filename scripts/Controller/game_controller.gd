extends Node

@export var quiz : QuizTheme
@export var color_correct : Color
@export var color_wrong : Color

var buttons : Array[Button]
var index : int = 0 
var right_questions : int

var current_quiz : QuizQuestion:
	get: return quiz.theme[index]
	
var points_array = [[10,7,4,1],[10,7,5,1],[10,7,4,1],[10,7,5,1],[10,7,4,1],[10,7,5,1],[10,7,4,1],[10,7,4,1],[10,7,5,1],[10,7,3,1]]

@onready var question_texts: Label = $Content/Question_Info_2/Question_Text_2
@onready var question_image: TextureRect = $Content/Question_Info_2/Question_Image_2
@onready var question_video: VideoStreamPlayer = $Content/Question_Info_OLD/Question_Assets/Question_Video
@onready var question_audio: AudioStreamPlayer = $Content/Question_Info_OLD/Question_Assets/Question_Audio

func _ready() -> void:
	$Content/Question_Options/Ani.play("fade")	
	
	for button in $Content/Question_Options/Ani.get_children():
		buttons.append(button)		
		button.disabled = true
	#randomize_questions(quiz.theme)
	load_quiz()
	await $Content/Question_Options/Ani.animation_finished
	for button in $Content/Question_Options/Ani.get_children():
		button.disabled = false
		
		
func load_quiz() -> void:
	if index >= quiz.theme.size():
		_game_over()
		return

	question_texts.text = current_quiz.question_info
	var choices = randomize_questions(current_quiz.options)
	for i in $Content/Question_Options/Ani.get_children().size():#buttons.size():
		buttons[i].text = choices[i]
		buttons[i].pressed.connect(_buttons_answer.bind(buttons[i]))

	match current_quiz.type:
		Enum.QuestionType.TEXT:
			$Content/Question_Info_2/Question_Image_2.hide()
		Enum.QuestionType.IMAGE:
			$Content/Question_Info_2/Question_Image_2.show()
			question_image.texture = current_quiz.question_image
		Enum.QuestionType.VIDEO:
			$Content/Question_Info_OLD/Question_Assets.show()
			question_video.stream = current_quiz.question_video
			question_video.play()
		Enum.QuestionType.AUDIO:
			$Content/Question_Info_OLD/Question_Assets.show()
			question_image.texture = current_quiz.question_image
			question_audio.stream = current_quiz.question_audio
			question_audio.play()

func _buttons_answer(button) -> void:
	#if current_quiz.correct_option == button.text:
	#	button.modulate = color_correct
	#	$Audio_Correct.play()
	#else:
	#	button.modulate = color_wrong
	#	$Audio_Wrong.play()
	if current_quiz.best_option == button.text:
		print("BEST")
		GlobalVar.pontos += points_array[index][0]
		$Audio_Correct.play()
	elif current_quiz.good_option == button.text:
		print("GOOD")
		GlobalVar.pontos += points_array[index][1]
		$Audio_Correct.play()
	elif current_quiz.ok_option == button.text:
		print("OK")
		GlobalVar.pontos += points_array[index][2]
		$Audio_Correct.play()
	else:
		print("BAD")
		GlobalVar.pontos += points_array[index][3]
		$Audio_Correct.play()
	_next_question()

func _next_question() -> void:
	print(GlobalVar.pontos)
	for button in $Content/Question_Options/Ani.get_children():#buttons:
		button.pressed.disconnect(_buttons_answer)
	await get_tree().create_timer(1).timeout
	for button in $Content/Question_Options/Ani.get_children():#buttons:
		button.modulate = Color.WHITE
	question_audio.stop()
	question_video.stop()
	question_audio.stream = null
	question_video.stream = null
	index += 1
	
	load_quiz()
	$Content/Question_Options/Ani.play("fade")
	for button in $Content/Question_Options/Ani.get_children():
		buttons.append(button)		
		button.disabled = true	
	await $Content/Question_Options/Ani.animation_finished
	for button in $Content/Question_Options/Ani.get_children():
		button.disabled = false
		
		
func randomize_questions(array: Array) -> Array:
	var array_temp = array
	array_temp.shuffle()
	return array_temp

func _game_over() -> void:
	get_tree().change_scene_to_file('res://scenes/results.tscn')
