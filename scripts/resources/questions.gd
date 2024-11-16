extends Resource
class_name QuizQuestion

@export var question_info : String
@export var type : Enum.QuestionType
@export var question_image : Texture2D
@export var question_audio : AudioStream
@export var question_video : VideoStream
@export var options : Array[String]
@export var best_option : String
@export var ok_option : String
@export var bad_option : String
@export var question_information : String
