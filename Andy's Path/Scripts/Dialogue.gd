extends Node

var UiReference
var playerReference
var dialogueReference

func _ready() -> void:
	UiReference = $"../CanvasLayer/UI"
	playerReference = $"../Player"
	dialogueReference = $"../CanvasLayer/UI/DialogueScreen/Dialogue"
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		Dialogue("res://Andy's Path/Resources/ExampleCharacterLines.tres")

func Dialogue(dialogueResource):
	UiReference.visible = true
	playerReference.is_cutscene = true
	dialogueReference.dialogFolder = dialogueResource
